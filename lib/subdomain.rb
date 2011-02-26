class Subdomain
  def self.get(request)
    Rails.env == 'test' ? Capybara.default_host.sub(/(.|)example.com/, "") : request.subdomain
  end

  def self.matches?(request)
    subdomain = self.get(request)

    subdomain.present? && subdomain != 'www'
  end
end
