require 'rails_helper'

describe Gateway::ApiGateway do
    let(:api_gateway) { Gateway::ApiGateway.new }
    let(:request_url) { 'https://yesno.wtf/api' }

    it 'can send a request to the api' do

        stub_request(:get, "https://yesno.wtf/api").to_return(status: 200, body: "{}", headers: {})
        api_gateway.get_random_yesno
        assert_requested :get, request_url
    end

    context 'the api returns yes' do
        let(:api_response) { 
            '{
                "answer": "yes",
                "image": "https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif"
            }'
        }

        let(:response_object) { api_gateway.get_random_yesno }

        before do
            stub_request(:get, "https://yesno.wtf/api").to_return(status: 200, body: api_response, headers: {})
        end
        
        it 'can return a YesNo with an answer' do
            expect( response_object.answer ).to eq('yes')
        end

        it 'can return a YesNo with an image' do
            expect( response_object.image ).to eq('https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif')
        end
    end

    context 'the api returns no' do
        let(:api_response) { 
            '{
                "answer": "no",
                "image": "https://yesno.wtf/assets/no/32-b62f1f8058c1d7f06c528319faccfb38.gif"
            }'
        }

        let(:response_object) { api_gateway.get_random_yesno }

        before do
            stub_request(:get, "https://yesno.wtf/api").to_return(status: 200, body: api_response, headers: {})
        end

        it 'can return a YesNo with an answer' do
            expect( response_object.answer ).to eq('no')
        end

        it 'can return a YesNo with an image' do
            expect( response_object.image ).to eq('https://yesno.wtf/assets/no/32-b62f1f8058c1d7f06c528319faccfb38.gif')
        end
    end
end