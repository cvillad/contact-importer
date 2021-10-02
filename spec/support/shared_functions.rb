
def invalid_expectation(instance, field)
  expect(instance).not_to be_valid
  expect(instance.errors[field.to_sym]).to include('is invalid')
end
