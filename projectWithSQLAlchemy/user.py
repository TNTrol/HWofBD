class MyUser():
	
	def __init__(self, name, role, id):
		self.username = name
		self.role = role
		self.id = id

	def is_authenticated(self):
		return True

	def is_active(self):
		return True

	def is_anonymous(self):
		return True

	def get_id(self):
		return self.id
