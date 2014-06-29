BASE_URL = "http://www.npr.org/programs/"

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

npr_ids = [
  2,
  13,
  3,
  5,
  46,
  35,
  7,
  10
]

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

joint_array = programs.zip(urls, npr_ids)
joint_array.each do |(program_name, url, npr_id)|
  Program.create(name: program_name, url: BASE_URL+url, slug: url, npr_id: npr_id)
end


