#Creates a simple interactive terminal emulator in a textbox. Doesn't support curses
#or taking user input, but can change directories, print out text outputs of programs.
class Terminal
  include Constants
  def initialize(root)
    @widget = TkText.new(root) do
      width DOC_WIDTH + 40
      height DOC_HEIGHT - 5
      grid('row' => TERM_ROW, 'column' => TERM_COLUMN)
    end
    @current_line = 1
    @current_dir = Dir.getwd
    
    @widget.bind("Return") do
      if @widget.index("insert").to_i === @current_line
        command = @widget.get("#{@current_line}.2", "#{@current_line}.end")
        @widget.insert("#{@current_line}.end", "\n")
        command = process_command(command)
        #Command set false if it shouldn't be run; otherwise, safe to run
        if command
          run_command(command)
        end
        @current_line += 1
        prompt_user
      end
      Tk.callback_break #Stops user-entered newline from appearing onscreen
    end
  end

  def prompt_user
    @widget.yview_moveto("#{@current_line}.1")
    @widget.insert("#{@current_line}.2", "$ ")
  end

  def process_command(command)
    command.downcase!
    
    if command === "exit"
      exit
    elsif command === "clear"
      @widget.insert("#{@current_line}.end", "\n" * @widget.height)
      @current_line += @widget.height
      return false
    elsif command.size >= 3 && command[0..2] === "cd "
      new_dir = command.split[1]
      #Absolute paths, home directory shouldn't be appended to current_dir,
      #  must become current_dir because they aren't relative paths
      case new_dir[0]
      when "/"
        @current_dir = new_dir
      when "~"
        #If "cd ~" or "~/test", ruby won't go to homedir, must specify Dir.home
        @current_dir = new_dir.sub(/~/, Dir.home)
     else
        @current_dir << "/" << new_dir
      end
      return false
    end
    return command
  end

  def run_command(command)
    process_command(command)
    #Handle unknown commands by user, which raise exception
    begin
      puts @current_dir
      output = Dir.chdir(@current_dir) do
        `#{command}`
      end
    rescue Errno::ENOENT
      output = "sh: Unknown command\n"
    end

    @current_line += output.count("\n")
    @widget.insert("insert", output)
  end
end
