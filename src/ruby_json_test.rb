
require "bundler/setup"
require "rubygems"
require "cloudmunch_sdk"
require "date"

class Ruby_json_App < AppAbstract

    def initializeApp()
        json_input = getJSONArgs()

        @jobname = json_input['loader_jobname']
        @greeting_param = json_input['greeting_param']
        @log_level = json_input['log_level'] 

        appContext = getAppContext(json_input)
        @domain = appContext.get_data('domain')
        @project = appContext.get_data('project')
        
        logInit(@log_level)
        log("info", "initializeApp is invoked in  Ruby_json_App")     
    end

    def process()
        log("info", "process is invoked in  Ruby_json_App")
        saveGreetingMessage(@greeting_param.to_json)
    end  

    def saveGreetingMessage(message)
        log("info", "saveGreetingMessage is invoked in  Ruby_json_App")
        log("debug", message)
        # the result_array needs to be stored into CMDB
        # updateCustomContext()
        @id = "messageid"
        log("info", "Updating cmdb with exceldata: id:"+@id) 

        data_pack = {
            "domain" => @domain,
            "project" => @project,
            "job" => @jobname,
            "context" => @greeting_param,
            "id" => @id,
            "data" => message
        }
        #pass the filled in hash object to the following method
        updateDataContextToCMDB(data_pack)  
    end 

    def cleanupApp()
        log("info", "cleanupApp is invoked in  Ruby_json_App")
        logClose()
    end


end

testPlugin = Ruby_json_App.new()
testPlugin.start()
