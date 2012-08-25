FactoryGirl.define do
  factory(:program) do
    sequence :name do |n|
      "Company #{n}"
    end
  end

  factory(:movie, class: "Movie", parent: :program)
  factory(:show, class: "Show", parent: :program)
  factory(:series, class: "Series", parent: :program)
  factory(:documentary, class: "Documentary", parent: :program)
end
