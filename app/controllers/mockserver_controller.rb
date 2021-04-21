class MockserverController < ApplicationController
  def create
    @body = ActiveSupport::JSON.decode(request.body.read)
    @req = @body["method"] + @body["path"]
    @res = {
      response: @body["response"],
      error: @body["error"],
      responseStatus: @body["responseStatus"]
    }
    @mock = Mock.where(request: @req).first
    if @mock.nil?
      @mock = Mock.new(request: @req, response: ActiveSupport::JSON.encode(@res))
      if @mock.save
        head 201
      else
        head 400
      end
    else
      @mock.update(response: ActiveSupport::JSON.encode(@res))
    end
  end
  def resolve
    @req = request.method.downcase + request.path
    puts @req
    @mock = ActiveSupport::JSON.decode(Mock.where(request: @req).first.response)
    @err = @mock["error"]
    puts @err
    if @err
      render :json => @err, :status => @mock["responseStatus"]
    else
      render :json => @mock["response"]
    end
  end
end
