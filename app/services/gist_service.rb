class GistService
  if Rails.env.production?
    ACCESS_TOKEN = ENV['GIST']
  else
    ACCESS_TOKEN = Rails.application.credentials.gist
  end


  Result = Struct.new(:html_url) do
    def success?
      html_url.present?
    end
  end

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    Result.new(@client.create_gist(gist_params).html_url)
  end

  private

  def gist_params
    {
      description: I18n.t('.description', title: @test.title),
      public: true,
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

  def default_client
    Octokit::Client.new(access_token: ACCESS_TOKEN)
  end
end
