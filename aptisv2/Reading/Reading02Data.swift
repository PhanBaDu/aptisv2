import Foundation

enum Reading02Part: Int, CaseIterable, Identifiable {
    case gapFill = 1
    case spaceOrdering = 2
    case musicOrdering = 3
    case personMatching = 4
    case headingMatching = 5

    var id: Int { rawValue }

    var title: String {
        "Part \(rawValue)"
    }
}

// MARK: - Part 1: Gap Fill

enum Reading02GapFill {
    static let instruction = "Read the email from Luis to his friend. Choose one word from the list for each gap. The first one is done for you."

    static let prefix = "Dear Shaun,\n\nI want to be healthier, so I exercise regularly.\n\nIn the "
    static let suffixAfterGap1 = ", I cycle to work.\n\nMy "
    static let suffixAfterGap2 = " thought this was a great idea and have joined me in this journey.\n\nTherefore, I "
    static let suffixAfterGap3 = " my car at my house.\n\nI feel "
    static let suffixAfterGap4 = " after cycling to work.\n\nThen, I drink water and eat healthy "
    static let suffixAfterGap5 = ".\n\nWrite soon,\nLuis."

    static let gaps: [GapFillItem] = [
        GapFillItem(id: 1, options: ["morning", "midday", "noon"], correctAnswer: "morning"),
        GapFillItem(id: 2, options: ["pets", "friends", "ancestors"], correctAnswer: "friends"),
        GapFillItem(id: 3, options: ["drive", "ride", "leave"], correctAnswer: "leave"),
        GapFillItem(id: 4, options: ["exhausting", "good", "average"], correctAnswer: "good"),
        GapFillItem(id: 5, options: ["food", "drinks", "beverage"], correctAnswer: "food"),
    ]
}

// MARK: - Part 2 & 3: Sentence Ordering

enum Reading02Ordering {
    static let firstAmericanWoman = SentenceOrderExercise(
        instruction: "The sentences below are about the first American woman in space. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "The first American woman in space",
        openingSentence: "Mae Raven was born into a distinguished, highly educated family in 1951.",
        sentences: [
            "This is about space, and it helps Mae to become a member of a research team.", // A -> 0
            "Some of those were about growing plants and some animals in a spaceship.", // B -> 1
            "With the support from her parents, she went to university to study science.", // C -> 2
            "As part of this group, she travelled to space and did a lot of experiments.", // D -> 3
            "Her degree enabled her to get a place on the training course in USA." // E -> 4
        ],
        // C -> E -> A -> D -> B
        correctOrder: [2, 4, 0, 3, 1]
    )

    static let musicShow = SentenceOrderExercise(
        instruction: "The sentences below are about a local event. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "Music show at the park",
        openingSentence: "The music show held at the central park last Saturday was the center of attention.",
        sentences: [
            "Many of them arrived early and visited nearby shops while they were waiting for it to begin.", // A -> 0
            "He performed for two hours and everyone had great fun.", // B -> 1
            "The staff there had a busy day, but they were able to close early and watch the famous singer perform.", // C -> 2
            "The local authority planned, sponsored, and paid for everything.", // D -> 3
            "Because of this, it was free and five thousand people attended it." // E -> 4
        ],
        // D -> E -> A -> C -> B
        correctOrder: [3, 4, 0, 2, 1]
    )
}

// MARK: - Part 4: Person Matching

enum Reading02PersonMatching {
    static let instruction = "Four people respond in the comments section of an online magazine article about a music festival. Read the texts and then answer the questions below."

    static let people: [PersonPassage] = [
        PersonPassage(
            id: "nadia",
            name: "Nadia",
            text: "This is my first time going to a concert, and the experience was quite mixed. During the first two days, the music was rather ordinary, and the event would have been far more enjoyable if there had been just a little sunshine to brighten things up. Luckily, the last day completely changed my impression, as I finally got to see my favorite singers. Meeting them and enjoying the performances made the whole trip memorable and truly special."
        ),
        PersonPassage(
            id: "cora",
            name: "Cora",
            text: "I attend music festivals every year, and over time it has become something of a personal tradition. I really enjoy the energetic atmosphere where people come together to share music and excitement. This particular festival, however, felt quite different from what I am used to. The weather conditions were less than perfect, though it didn't bother me that much, as I have enjoyed festivals in the rain before. The venue was moderately convenient and the performances themselves were rather unremarkable. To be honest, I doubt I will choose to come back in the future."
        ),
        PersonPassage(
            id: "alek",
            name: "Alek",
            text: "I don't like one particular type of music being played at festivals, as I much prefer a variety of genres to enjoy and dance to. Luckily, this event truly lived up to what I was hoping for. The songs and melodies were absolutely impressive, leaving a strong impression on me. Although there was some rain, I actually felt it made the atmosphere even more vibrant and fun. One drawback, however, was the ticket price was quite high, which many students, including me, found difficult to afford."
        ),
        PersonPassage(
            id: "farhan",
            name: "Farhan",
            text: "My band and I were invited to play at this festival, and we delivered the kind of performance our audience has come to expect from us. The show turned out to be truly memorable, not only because of the energy on stage but also because some of our former members and past collaborators were present. It felt great to reconnect with them and share stories after the performance. The only real drawback was that the venue was located quite far from the main road, which made moving our instruments and equipment rather inconvenient."
        ),
    ]

    static let questions: [PersonMatchQuestion] = [
        PersonMatchQuestion(id: 1, question: "Who thought the event was expensive?", correctPerson: "Alek"),
        PersonMatchQuestion(id: 2, question: "Who likes meeting old friends?", correctPerson: "Farhan"),
        PersonMatchQuestion(id: 3, question: "Who was not impressed by the event overall?", correctPerson: "Cora"),
        PersonMatchQuestion(id: 4, question: "Who enjoyed the final day of the music event?", correctPerson: "Nadia"),
        PersonMatchQuestion(id: 5, question: "Who thought the location was not good?", correctPerson: "Farhan"),
        PersonMatchQuestion(id: 6, question: "Who is disappointed with the weather?", correctPerson: "Nadia"),
        PersonMatchQuestion(id: 7, question: "Who enjoyed all the music at the music event?", correctPerson: "Alek"),
    ]

    static let personNames = ["Nadia", "Cora", "Alek", "Farhan"]
}

// MARK: - Part 5: Heading Matching

enum Reading02HeadingMatching {
    static let instruction = "Read the passage quickly. Choose a heading for each numbered paragraph (1–7) from the list. There is one more heading than you need."

    static let passageTitle = "THE ARRIVAL OF THE FOUR-DAY WEEK"

    static let openingHeading = "Conflicting beliefs"
    static let openingParagraph = "For much of modern history, working long hours has been seen as a sign of commitment and productivity..."

    static let paragraphs: [String] = [
        "For decades, many organisations have continued to operate according to tradition, meaning going to work nine-to-five repeatedly five days a week...",
        "Under the traditional five-day system, individuals frequently struggle to find sufficient time for family commitments, physical health, and recreational activities...",
        "Many employers remain sceptical about reducing the number of working days, primarily due to concerns about financial performance... output falling by approximately 30 percent...",
        "While some organisations claim that tasks can still be completed within fewer days, this often requires workers to operate at a much higher intensity...",
        "Another important factor to consider is human psychology... Initially, employees often respond positively to the idea of having an extra day off... However, research suggests that this effect may not last indefinitely...",
        "Certain professions require consistent availability and cannot easily adapt to reduced schedules. For example, teachers are still expected to deliver a fixed curriculum...",
        "Given these challenges, it may be more effective for organisations to adjust flexibly rather than simply adopting a universal four-day working week..."
    ]

    static let headings: [HeadingOption] = [
        HeadingOption(id: "A", label: "A", text: "Alternative solutions worth considering"),
        HeadingOption(id: "B", label: "B", text: "Undesirable financial consequences"),
        HeadingOption(id: "C", label: "C", text: "A better way to do business"),
        HeadingOption(id: "D", label: "D", text: "Difficult to give up old habits"),
        HeadingOption(id: "E", label: "E", text: "Benefits for employees"),
        HeadingOption(id: "F", label: "F", text: "An unfair plan for some people"),
        HeadingOption(id: "G", label: "G", text: "A way of life now out of date"),
        HeadingOption(id: "H", label: "H", text: "Unforeseen challenges for employees"),
    ]

    static let correctOrder: [String] = ["G", "E", "B", "H", "D", "F", "A"]
}
