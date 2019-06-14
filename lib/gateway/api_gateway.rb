class Gateway::ApiGateway
    def get_random_yesno
        response = HTTParty.get('https://yesno.wtf/api')
        response_parsed = JSON.parse response, symbolize_names: true
        Domain::YesNo.new.tap do |yes_no|
            yes_no.answer = response_parsed[:answer]
            yes_no.image = response_parsed[:image]
        end
    end
end