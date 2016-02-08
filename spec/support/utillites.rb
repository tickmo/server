# Helper's methods static_pages_spec.rb
def full_title(page_title)
  base_title = "Tickmo"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def have_rigth_links(link, title)
  click_link link
  expect(page).to have_title(full_title(title))
end

def have_heading_title(heading, options = {title: heading})
  it { should have_selector('h1', text: heading) }
  it { should have_title(options[:title]) }
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end
