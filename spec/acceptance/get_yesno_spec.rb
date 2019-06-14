require 'rails_helper'

describe 'Get Random YesNo' do
    context 'when the option is a yes' do
        let(:api_response) { 
            '{
                "answer": "yes",
                "image": "https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif"
            }'
        }

        it 'can get yes information from api' do
            stub_request(:get, "https://yesno.wtf/api").to_return(status: 200, body: api_response, headers: {})
            api_gateway = Gateway::ApiGateway.new
            get_yesno = UseCase::GetYesNo.new(
                gateway: api_gateway
            )
            response = get_yesno.execute

            expect(response).to eq(
                {
                    answer: "yes",
                    image: "https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif"
                }
            )
        end
    end
end