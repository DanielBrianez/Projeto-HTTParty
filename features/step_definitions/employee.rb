Dado('que o usuario consulte informacoes de funcionario') do
  @getlist = Employee_Requests.new
end
  
Quando('ele realizar a pesquisa') do
  @list_employee = @getlist.find_employee
end
  
Entao('uma lista de funcionarios deve retornar') do
  expect(@list_employee.code).to eql 200
  expect(@list_employee.message).to eql 'OK'
end

Dado('que o usuario cadastre um novo usuario') do
  @create = Employee_Requests.new
  @assert = Assertions.new
  @name = Faker::Name.name
  @salary = Faker::Number.number
  @age = Faker::Number.number(digits: 2)
  puts @name
  puts @salary
  puts @age
end

Quando('ele enviar as informacoes do funcionario') do
  @create_employee = @create.create_employee(@name, @salary, @age)
  puts @create_employee
end

Entao('esse funcionario sera cadastrado') do
  @assert.request_success(@create_employee.code, @create_employee.message)
  expect(@create_employee["status"]).to eql 'success'
  expect(@create_employee["message"]).to eql 'Successfully! Record has been added.'
  expect(@create_employee['data']["employee_name"]).to eql @name
  expect(@create_employee['data']["employee_salary"]).to eql @salary
  expect(@create_employee['data']["employee_age"]).to eql @age
end

Dado('que o usuario altere uma informacao de um funcionario') do
  @request = Employee_Requests.new
end

Quando('ele enviar as novas informacoes') do
  @update_employee = @request.update_employee(@request.find_employee ['data'][0]['id'], 'Another Fake person', 35000, 40)
  puts @update_employee
end

Entao('as informacoes serao alteradas') do
  expect(@update_employee.msg).to eql ('OK')
  expect(@update_employee.code).to eql (200)
  expect(@update_employee["status"]).to eql 'success'
  expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
  expect(@update_employee['data']["employee_name"]).to eql 'Another Fake person'
  expect(@update_employee['data']["employee_salary"]).to eql (35000)
  expect(@update_employee['data']["employee_age"]).to eql (40)
end

Dado('que o usuario queira deletar um funcionario') do
  @getlist = Employee_Requests.new
  @delete_url = '/delete/' + @get_employee['data'][0]['id'].to_s
end

Quando('ele enviar a identificacao unica') do
  @delete_employee = request.delete_employee(@request.find_employee['data'][0]['id'])
  puts (@delete_employee)
end

Entao('esse funcionario sera deletado do sistema') do
  expect(@delete_employee.msg).to eql ('OK')
  expect(@delete_employee.code).to eql (200)
  expect(@delete_employee["status"]).to eql 'success'
  expect(@delete_employee["data"]).to eql '25'
  expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted.'
end