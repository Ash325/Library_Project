json.array! @users do |user|
    json.mobile_no user.mobile_no
    json.id user.id
    json.name user.name
    json.username user.username
    json.email user.email
  end