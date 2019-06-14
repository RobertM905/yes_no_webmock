require 'rails_helper'

describe UseCase::GetYesNo do
    let(:api_gateway) { spy }
    let(:get_yesno) { UseCase::GetYesNo.new( gateway: api_gateway) }

    it 'can call the gateway' do
        get_yesno.execute

        expect(api_gateway).to have_received(:get_random_yesno)
    end


    context 'when the gateway returns a yes' do
        let(:yes_no) do
            Domain::YesNo.new.tap do |yes_no|
                yes_no.answer = 'yes'
                yes_no.image = 'https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif'
            end
        end

        let(:api_gateway) { double(get_random_yesno: yes_no) }
      it 'can get the response from the gateway' do
            response = get_yesno.execute
            expect(response).to eq(
                {
                    answer: "yes",
                    image: "https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif" 
                }
            )
      end
    end

    context 'when the gateway returns a no' do
        let(:yes_no) do
            Domain::YesNo.new.tap do |yes_no|
                yes_no.answer = 'no'
                yes_no.image = 'https://yesno.wtf/assets/no/32-b62f1f8058c1d7f06c528319faccfb38.gif'
            end
        end

        let(:api_gateway) { double(get_random_yesno: yes_no) }

        it 'can get the response from the gateway' do
            response = get_yesno.execute
            expect(response).to eq(
                {
                    answer: "no",
                    image: "https://yesno.wtf/assets/no/32-b62f1f8058c1d7f06c528319faccfb38.gif"
                }
            )
      end
    end
end