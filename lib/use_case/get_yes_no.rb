class UseCase::GetYesNo
    def initialize(gateway:)
        @gateway = gateway
    end

    def execute
        yesno = @gateway.get_random_yesno
        {
            answer: yesno.answer,
            image: yesno.image
        }
    end
end