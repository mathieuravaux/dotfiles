require 'rubygems'

# require 'irb/completion'
# ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 2500
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# require 'utility_belt'


# class Object
#   # Clone fails on numbers, but they're immutable anyway
#   def megaClone
#     begin self.clone; rescue; self; end
#   end
# 
#   def what?(*a)
#     MethodFinder.new(self, *a)
#   end
# 
# end


# class MethodFinder
# 
#   # Find all methods on [anObject] which, when called with [args] return [expectedResult]
#   def self.find( anObject, expectedResult, *args )
#     anObject.methods.select { |name| anObject.method(name).arity == args.size }.
#                      select { |name| begin anObject.megaClone.method( name ).call(*args) == expectedResult; 
#                                      rescue; end }
#   end
# 
#   # Pretty-prints the results of the previous method
#   def self.show( anObject, expectedResult, *args )
#     find( anObject, expectedResult, *args ).each { |name|
#       print "#{anObject.inspect}.#{name}" 
#       print "(" + args.map { |o| o.inspect }.join(", ") + ")" unless args.empty?
#       puts " == #{expectedResult.inspect}" 
#     }
#   end
# 
#   def initialize( obj, *args )
#     @obj = obj
#     @args = args
#   end
# 
#   def ==( val )
#     MethodFinder.show( @obj, val, *@args )
#   end
# end



def loop_execute(file)
  old_mtime = nil
  loop do
    print("\e[sWaiting...")
    sleep(0.2) while (mtime = File.stat(file).mtime) == old_mtime
    print("\e[u\e[K")
    begin
      r = eval(File.read(file))
      puts("=> #{r.inspect}")
    rescue IRB::Abort
      puts("Abort")
      return
    rescue Exception => e
      puts("#{e.class}: #{e.message}\n#{e.backtrace.join("\n")}")
    end
    old_mtime = mtime
  end
end



# require 'shell'
# 
# # Override the command processor widget for inserting system commands so
# # that it behaves more like path-processing: earlier commands take precedence.
# require 'shell/command-processor'
# module FixAddDelegateCommandToShell
#   def self.extended(obj)
#     class << obj
#       alias_method :add_delegate_command_to_shell_override, :add_delegate_command_to_shell unless method_defined?(:add_delegate_command_to_shell_override)
#       alias_method :add_delegate_command_to_shell, :add_delegate_command_to_shell_no_override
#     end
#   end
# 
#   def add_delegate_command_to_shell_no_override(id)
#     id = id.intern if id.kind_of?(String)
#     name = id.id2name
#     if Shell.method_defined?(id) or Shell::Filter.method_defined?(id)
#       Shell.notify "warn: Not overriding existing definition of Shell##{name}."
#     else
#       add_delegate_command_to_shell_override(id)
#     end
#   end
# end
# Shell::CommandProcessor.extend(FixAddDelegateCommandToShell)

# Allow Shell system commands to take :symbols too, to save a little typing.
# require 'shell/system-command'
# class Shell
#   class SystemCommand
#     alias_method :initialize_orig, :initialize
#     def initialize(sh, command, *opts)
#       opts.collect! {|opt| opt.to_s }
#       initialize_orig sh, command, *opts
#     end
#   end
# end

# Provide me with a shell inside IRB to save quitting and restarting, or
# finding that other terminal window.
# def shell
#   unless $shell
#     Shell.install_system_commands '' # no prefix
#     $shell = Shell.new
#   end
#   $shell
# end
# 
# def sh
#   unless $sh
#     Shell.install_system_commands '' # no prefix
#     $sh = Shell.new
#   end
#   $sh
# end


def mate(content, filename='debug.txt')
  File.open(filename, 'w') { |f| f.write(content) }
  `mate #{filename}`
end 

if rails_env = ENV['RAILS_ENV']
  rails_root = File.basename(Dir.pwd)
  prompt = "#{rails_root}[#{rails_env.sub('production', 'prod').sub('development', 'dev')}]"
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{prompt}>> ",
    :PROMPT_S => "#{prompt}* ",
    :PROMPT_C => "#{prompt}? ",
    :RETURN => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS
 
  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  # IRB.conf[:IRB_RC] = Proc.new do
  #   begin
  #     ActiveRecord::Base.logger = Logger.new(STDOUT)
  #     ActiveRecord::Base.instance_eval { alias :[] :find }
  #   rescue
  #     puts "ActiveRecord::Base additions for irb not loaded. see ~/.irbrc"
  #   end
  # end
end
 
 
# Enables items.map(&:name) in regular irb
class Symbol
  def to_proc
    lambda {|*args| args.shift.__send__(self, *args)}
  end
end

