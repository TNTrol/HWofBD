class MyUser():
	username = 'TNT'
	
	def __init__(self, name, role, id, private_id):
		self.username = name
		self.role = role
		self.id = id
		self.private_id = private_id

	def is_authenticated(self):
		return True

	def is_active(self):
		return True

	def is_anonymous(self):
		return True

	def get_id(self):
		return self.id
