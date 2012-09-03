class Program < ActiveRecord::Base
  attr_accessible :name
  WORDS  = [
    ["My Wife and", "All in the", "American", "Arrested", "Big Blue", "Bionic", "Blansky's", "Boy Meets", "Cannon", "Charlie's", "Chico and the", "Dance", "Dancing with the", "Days of our", "Deadliest", "Desperate", "Diff'rent", "Dukes of", "Earth: Final", "Eight is", "Electric", "Fantasy", "Freaks and", "Gimme a", "Golden", "Good", "Green", "Grey's", "Grounded for", "Growing", "Happy", "How I Met Your", "I Dream of", "I Love", "In Search of...", "Jake and the", "Joanie Loves", "King of", "King of the", "Law and", "Leave it to", "Little House on the", "Love", "M*A*S*H", "Mad About", "Malcom in the", "Married...with", "Miami", "My Favorite", "My Mother the", "My Two", "Northern", "One Day at a", "Petticoat", "Prison", "Quantum", "Sanford and ", "Saved by the", "Scarecrow and", "Sesame", "Sex and the", "Six-Million Dollar", "Soap", "Star", "Starsky and", "The Beverly", "The Brady", "The Days and Nights of", "The Facts of", "The King of", "The Odd", "The Rockford", "The White", "The Wind in the", "The Wonder", "Three", "Three's", "Too Close for", "Trading", "Trapper John,", "Twin", "Two and a Half", "Ugly", "What I Like About", "Wheel of", "Wonder", "Everybody Loves", "Everybody Hates", "Hidden", "King of the", "Mama's", "Family", "Diagnosis", "Murder", "The Wonder", "CSI:", "Law & Order:", "Deal or No", "That's So", "Star", "What's", "Bonanza", "Walker, ", "Welcome Back,", "Space", "Wait Till Your Father Gets", "The Fall", "Teenage Mutant Ninja", "Mission", "Flipper", "Bosom", "The Outer", "Picket", "Mystery Science", "A Different", "Alien", "Amazing", "That's", "Baa Baa Black", "Blue", "Doogie Howser,", "Emergency!", "Family", "Father", "Flying", "Full", "Greatest American", "Hardcastle &", "Hardy", "Highway to", "I Married", "Incredible", "Johnny", "Knight", "Knots", "Land of the", "Little", "Lone", "Lost in", "Mutual of Omaha's Wild", "Naked", "Night", "Odd", "Passport to", "Pee-Wee's", "Planet of the", "Return of the Man from", "Sigmund and the", "The Soupy", "St.", "Tales from the", "That's My", "Third Rock from the", "This is Your", "T.J.", "Thorn", "Three", "Three's", "Touched by a(n)", "Twilight", "Wanted Dead or", "Woody", "You Bet Your", "In the Heat of the", "Absolutely", "According to", "The Amazing", "Amazing", "America's Funniest", "America's Most", "America's Next Top", "American", "American", "B.J. and the", "Battlestar", "Beat the", "Beauty and the", "Behind the", "Buffy the", "Candid", "Captain", "Car 54", "Charmed", "The Courtship of", "Criminal", "The Crocodile", "Crossing", "Curb Your", "Dance", "Dancing with the", "Dark", "The Dating", "Dawson's", "The Dead", "Deal or", "Dennis the", "Designing", "Early", "Eight", "Family", "Family", "Fantasy", "Father Knows", "Full", "Get", "Gimme a", "Grace Under", "Grey's", "Grounded For", "Hearts", "Home", "How I Met Your", "Howdy", "In Living", "Jake and the", "The Joker's", "Judging", "Mad About", "Major", "Make Room for", "Mama's", "Man from", "Misfits of", "The Mod", "The Muppet", "My Mother the", "My Name Is", "My So-Called", "My Three", "Name That", "Night", "The People's", "Perfect", "The Price is", "Real", "Rich Man", "Sabrina,", "Silk", "Silver", "The Simple", "Six Feet", "The Six Million Dollar", "Small", "Spin", "Starsky and", "Still", "Suddenly", "Taxi", "That", "That's", "This Is Your", "Truth or", "Two and a Half", "Two Guys, A Girl and a", "Wanted:", "The Weakest", "Wheel of", "Who's the", "Who Wants To Be A", "Win, Lose, or", "Without a", "Xena:", "Yes,", "You Bet Your", "You Can't Do That on", "House", "RENO", "3rd Rock from the", "Dirty"],
    ["Kids", "Jobs", "from the Sun", "Men", "Family", "Idol", "Development", "Marble", "Woman", "Beauties", "World", "Cannon", "Angels", "Man", "Fever", "Stars", "Lives", "Catch", "Housewives", "Strokes", "Hazzard", "Conflict", "Enough", "Company", "Island", "Geeks", "Break", "Girls", "Times", "Acres", "Anatomy", "Life", "Pains", "Days", "Mother", "Jeanie", "Lucy", "Fatman", "Chachi", "Queens", "Order", "Beaver", "Prairie", "Boat", "M*A*S*H", "You", "Middle", "Children", "Vice", "Martian", "Car", "Dads", "Exposure", "Time", "Junction", "Break", "Leap", "Son", "Bell", "Mrs. King", "Street", "City", "Man", "Soap", "Search", "Hutch", "Hillbillies", "Bunch", "Molly Dodd", "Life", "Queens", "Couple", "Files", "Shadow", "Willows", "Years", "Stooges", "Company", "Comfort", "Spaces", "MD", "Peaks", "Men", "Betty", "You", "Fortune", "Years", "Raymond", "Chris", "Palms", "Hill", "Family", "Guy", "Murder", "She Wrote", "Years", "Miami", "Criminal Intent", " Deal", "Raven", "Trek", "Happening", "Bonanza", "Texas Ranger", "Kotter", "Ghost", "Home", "Guy", "Turtles", "Impossible", "Ironside", "Flipper", "Buddies", "Limits", "Fences", "Theater", "World", "Nation", "Stories", "Incredible", "Sheep", "Thunder", "MD", "Emergency!", "Affair", "Murphy", "Nun", "House", "Hero", "McCormick", "Boys", "Heaven", "Joan", "Hulk", "Quest", "Rider", "Landing", "Lost", "Rascals", "Quest", "Space", "Kingdom", "City", "Court", "Couple", "Danger", "Playhouse", "Apes", "UNCLE", "Sea Monsters", "Sales Show", "Elsewhere", "Crypt", "Mama", "Sun", "Life", "Hooker", "Birds", "Stooges", "Company", "Angel", "Zone", "Alive", "Woodpecker", "Life", "Night", "Beaver", "Beaver", "Beaver", "Beaver", "Fabulous", "Jim", "Race", "Stories", "Home Videos", "Wanted", "Model", "Bandstand", "Gladiators", "Bear", "Galactica", "Clock", "Beast", "Music", "Vampire Slayer", "Camera", "Kangaroo", "Where Are You?", "Charmed", "Eddie's Father", "Minds", "Hunter", "Jordan", "Enthusiasm", "Fever", "Stars", "Angel", "Game", "Creek", "Zone", "No Deal", "Menace", "Women", "Edition", "is Enough", "Feud", "Ties", "Island", "Best", "House", "Smart", "Break", "Fire", "Anatomy", "Life", "Afire", "Improvement", "Mother", "Doody", "Color", "Fatman", "Wild", "Amy", "You", "Dad", "Daddy", "Family", "Atlantis", "Science", "Squad", "Show", "Car", "Earl", "Life", "Sons", "Tune", "Stalker", "Court", "Strangers", "Right", "People", "Poor Man", "the Teenage Witch", "Stalkings", "Spoons", "Life", "Under", "Man", "Wonder", "City", "Hutch", "Standing", "Susan", "Taxi", "Girl", "Incredible!", "Life", "Consequences", "Men", "a Girl", "Dead or Alive", "Link", "Fortune", "Boss?", "Millionaire?", "Draw", "Trace", "Warrior Princess", "Dear", "Life", "Television", "Beaver", "Hill", "911"]
  ]

  belongs_to :company

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_inclusion_of :available, :in => [true, false]

  scope :available, where(available: true)

  def self.generate
    program = self.new(name: random_name)
    program.available = true
    program.price = rand(9_900) + 100
    program.save
    program
  end

  def as_json(*args)
    {
      id: self.to_param,
      name: self.name
    }
  end

  private

  # This is not tested
  def self.random_name
    "%s %s" % [WORDS[0].sample, WORDS[1].sample]
  end
end
