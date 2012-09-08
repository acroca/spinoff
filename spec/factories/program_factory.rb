FactoryGirl.define do
  factory(:program) do
    sequence :name do |n|
      "Company #{n}"
    end
    genre 'action'

    after(:build) do |program|
      unless program.company
        user = create(:user)
        program.company = user.company
      end
    end
  end

  factory(:movie, class: "Movie", parent: :program)
  factory(:show, class: "Show", parent: :program)
  factory(:series, class: "Series", parent: :program)
  factory(:documentary, class: "Documentary", parent: :program)
end
