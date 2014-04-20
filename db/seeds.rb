programs = [
  "All Things Considered",
  "Fresh Air",
  "Morning Edition",
  "Talk of the Nation",
  "Tell Me More",
  "Wait Wait...Don't Tell Me",
  "Weekend Edition Saturday",
  "Weekend Edition Sunday"
]

BASE_URL = "http://www.npr.org/programs/"

urls = [
  "all-things-considered",
  "fresh-air",
  "morning-edition",
  "talk-of-the-nation",
  "tell-me-more",
  "wait-wait-dont-tell-me",
  "weekend-edition-saturday",
  "weekend-edition-sunday"
]

joint_array = programs.zip(urls)
joint_array.each do |(program_name, url)|
  Program.create(name: program_name, url: BASE_URL+url, slug: url)
end


