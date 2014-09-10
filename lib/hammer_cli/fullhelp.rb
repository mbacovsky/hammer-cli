module HammerCLI

  class FullHelpCommand < AbstractCommand

    def execute
      puts HammerCLI::MainCommand.new("", {}).help; puts
      print_help_recursive

      HammerCLI::EX_OK
    end

    private

    def print_help_recursive(command_name='hammer', command=HammerCLI::MainCommand)
      command.recognised_subcommands.each do |subcommand_container|
        subcommand_class = subcommand_container.subcommand_class
        subcommand = subcommand_class.new("", {})
        name = "#{command_name} > #{subcommand_container.names.first}"
        puts name
        puts '-' * name.length
        puts subcommand_container.description
        puts subcommand.help
        puts
        print_help_recursive name, subcommand_class
      end
    end

   end

  HammerCLI::MainCommand.subcommand "full-help", _("Recursive help"), HammerCLI::FullHelpCommand
end
