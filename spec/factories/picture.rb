FactoryBot.define do
  factory :picture do
    author  { 'HiNaru' }
    finish  { 'Silk' }
    condition { 'New' }
    image  { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/example.jpg"), "image/jpeg") }
    title  { 'haha' }
    price  { 111 }
    model  { 'sakuracha' }
    description { 'qwqraczxcsefdsdfas' }
    user
  end
end
