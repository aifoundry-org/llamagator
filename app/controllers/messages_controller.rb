class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[ show edit update destroy ]

  def index
    @message = Message.new
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @messages = Message.all
    @message = @chat.messages.new(message_params)

    respond_to do |format|
      if @message.save
        # FIXME: this is a massive hack
        # client = OpenAI::Client.new
        # response = client.chat(parameters: {
        #                          model: "gpt-3.5-turbo",
        #                          messages: [{ role: "user", content: @message.body }],
        #                          temperature: 0.5
        #                        })
        # Message.create body: "CHATGPT: " + response.dig("choices", 0, "message", "content")
        # FIXME: the hack ends here
        
        format.html { redirect_to chat_message_url(@chat, @message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to chat_message_url(@chat, @message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to chat_messages_url(@chat), notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end
  
    def set_message
      @message = @chat.messages.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
