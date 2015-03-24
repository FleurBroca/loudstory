class SubscribeToNewsletter
  def initialize
    @gibbon = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_LIST_ID']
  end

  def run(params)
    @gibbon.lists.subscribe({
      id: @list_id,
      email: { email: params[:email] },
      merge_vars: {
        FNAME: params[:first_name],
        LNAME: params[:last_name]
      },
      double_optin: false,
      update_existing: true
    })
  end
end


