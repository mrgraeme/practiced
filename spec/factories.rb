# By using the symbol ':user', we get Factory Girl to simulate the User model.

Factory.define :user do |user|
  user.name "Graeme Benstead-Hume"
  user.email "graeme@jumpdigital.co.uk"
  user.password "password"
  user.password_confirmation "password"
end

