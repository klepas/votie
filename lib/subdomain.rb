class Subdomain
  def self.get(request)
    if Rails.env == 'test' && (request.subdomain.nil? || request.subdomain.blank?)
      Capybara.default_host.sub(/(.|)example.com/, "")
    else
      request.subdomain
    end
  end

  def self.matches?(request)
    subdomain = self.get(request)

    subdomain.present? && subdomain != 'www'
  end
end
