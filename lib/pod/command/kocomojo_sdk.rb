require 'xcodeproj'

module Pod 
  class Command 
    class KocomojoSdk < Command 
      self.summary = "KocomojoSDK utility"
      self.description = <<-DESC
        Finalize installation of KocomojoSDK in specified `XCODEPROJ`
      DESC

      self.arguments = [
        CLAide::Argument.new('XCODEPROJ', true)
      ]

      def initialize(argv)
        @xcodeproj = argv.shift_argument 

        # if none specified then use first .xcodeproj if there's 1 (and only 1)
        if !@xcodeproj && Dir['*.xcodeproj'].count == 1 
          @xcodeproj = Dir['*.xcodeproj'].first 
        end 
        
        super 
      end 

      def validate! 
        super 
        unless @xcodeproj 
          help! "Please specify your .xcodeproj"
        end 

        unless File.directory?(@xcodeproj)
          help! "Unable to find #{@xcodeproj}"
        end
      end 

      def run 
        project = Xcodeproj::Project.open(@xcodeproj)
        main_target = project.targets.first

        phase = nil

        # see if we can reuse existing build phase 
        main_target.build_phases.each do |cur_phase|
          next unless cur_phase.class == Xcodeproj::Project::Object::PBXShellScriptBuildPhase 

          next unless cur_phase.name == 'Kocomojo Strip Framework Architecture'
          phase = cur_phase
        end

        # create new if necessary
        if phase.nil?
          phase = main_target.new_shell_script_build_phase("Kocomojo Strip Framework Architecture")
        end

        phase.shell_script = %{if [ -e "\${BUILT_PRODUCTS_DIR}/\${FRAMEWORKS_FOLDER_PATH}/KocomojoSDK.framework/strip-frameworks.sh" ]; then
bash "\${BUILT_PRODUCTS_DIR}/\${FRAMEWORKS_FOLDER_PATH}/KocomojoSDK.framework/strip-frameworks.sh"
fi}

        project.save()
      end 
    end
  end
end