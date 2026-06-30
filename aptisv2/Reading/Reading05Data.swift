import Foundation

enum Reading05Part: Int, CaseIterable, Identifiable {
    case gapFill = 1
    case cafeOrdering = 2
    case homeworkOrdering = 3
    case personMatching = 4
    case headingMatching = 5

    var id: Int { rawValue }

    var title: String {
        "Part \(rawValue)"
    }
}

// MARK: - Part 1: Gap Fill

enum Reading05GapFill {
    static let instruction = "Read the email from Belle to her parents. Choose one word from the list for each gap. The first one is done for you."

    static let prefix = "Dear Dad and Mom,\n\nI just finished my class.\n\nEveryone in the class is very "
    static let suffixAfterGap1 = ".\n\nI have rented a room that is quite close to the school, so I can "
    static let suffixAfterGap2 = " to school.\n\nThis is the "
    static let suffixAfterGap3 = " time I've had a conversation with Lesley. She is my roommate.\n\nShe is studying French and can "
    static let suffixAfterGap4 = " five languages.\n\nTonight, we will hang out and have dinner "
    static let suffixAfterGap5 = ".\n\nLove,\nBelle."

    static let gaps: [GapFillItem] = [
        GapFillItem(id: 1, options: ["closely", "friendly", "likely"], correctAnswer: "friendly"),
        GapFillItem(id: 2, options: ["follow", "fly", "walk"], correctAnswer: "walk"),
        GapFillItem(id: 3, options: ["first", "begin", "start"], correctAnswer: "first"),
        GapFillItem(id: 4, options: ["talk", "speak", "say"], correctAnswer: "speak"),
        GapFillItem(id: 5, options: ["other", "together", "another"], correctAnswer: "together"),
    ]
}

// MARK: - Part 2 & 3: Sentence Ordering

enum Reading05Ordering {
    static let newCafeInTown = SentenceOrderExercise(
        instruction: "The sentences below are about a new cafe. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "New Cafe in Town",
        openingSentence: "I visited the newly opened cafe last Saturday.",
        sentences: [
            "I had to choose one of those so I decided to choose the most expensive sandwiches.", // A -> 0
            "It was full of people, and the staff were working hard on their first day.", // B -> 1
            "It was really good with cheese topping and I would come back to this place.", // C -> 2
            "When I first looked at the menu, I was disappointed since I hoped to see a variety of dishes.", // D -> 3
            "Despite the crowd, they found me a nice table and brought me a menu." // E -> 4
        ],
        // B -> E -> D -> A -> C
        correctOrder: [1, 4, 3, 0, 2]
    )

    static let homeworkNextWeek = SentenceOrderExercise(
        instruction: "The sentences below are some school instructions. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "Homework Next Week",
        openingSentence: "The following is the guidance for next week's assignment.",
        sentences: [
            "There may not be many of those, but still you will see some common areas.", // A -> 0
            "Before starting writing, you should do research on many details of that place.", // B -> 1
            "While giving information about the three areas, you will also compare it with your own country.", // C -> 2
            "This comparison will help you understand the similarities between the two countries.", // D -> 3
            "These must include data on its people, language, and history." // E -> 4
        ],
        // B -> E -> C -> D -> A
        correctOrder: [1, 4, 2, 3, 0]
    )
}

// MARK: - Part 4: Person Matching

enum Reading05PersonMatching {
    static let instruction = "Four people respond in the comments section of an online magazine article about volunteering. Read the texts and then answer the questions below."

    static let people: [PersonPassage] = [
        PersonPassage(
            id: "boyd",
            name: "Boyd",
            text: "I understand many young people like volunteering abroad. Some are hoping to gain experience that will look good on their résumés, while others are interested in meeting new people from different backgrounds. Although these reasons are valid, I personally feel that giving support closer to home is more meaningful. Contributing to neighbourhood projects can create a stronger impact; for example, individuals may develop a deeper appreciation of their own traditions, ethnic values, and regional specialities."
        ),
        PersonPassage(
            id: "elly",
            name: "Elly",
            text: "My mother was very involved in local charities, particularly those connected to nature protection and maintaining traditional customs. Seeing her commitment encouraged me to take part in a volunteer programme myself. Initially, I believed it would be useful for developing professional skills that would impress my future employers, and it actually did. However, what stood out most was the opportunity to connect with others. Working alongside like-minded people made it easy to form friendships, which has become the main reason I continue volunteering today."
        ),
        PersonPassage(
            id: "noah",
            name: "Noah",
            text: "I'm busy with work these days, and since I travel abroad frequently for work, I don't really have spare time for unpaid activities. With a possible promotion coming up, my responsibilities will likely increase even more. That said, I do recognise the positive effects such experiences can have on a person, and I plan to get involved later in life. For the moment, I prefer to contribute financially, as I believe this is an equally helpful way to support important causes."
        ),
        PersonPassage(
            id: "chinua",
            name: "Chinua",
            text: "I don't have many financial resources, but I've discovered a few programmes that make it possible to join projects in other countries without paying through the nose. I really enjoy these opportunities because they allow me to explore places I wouldn't normally consider visiting. Without a meaningful purpose like helping others, I would probably remain in my local area, knowing only people within my community. In addition, many of these volunteering activities involve heavy lifting duties, which actually help me stay fit and energetic."
        ),
    ]

    static let questions: [PersonMatchQuestion] = [
        PersonMatchQuestion(id: 1, question: "Who thinks volunteering can be helped by giving money?", correctPerson: "Noah"),
        PersonMatchQuestion(id: 2, question: "Who thinks volunteering is a good way to make friends?", correctPerson: "Elly"),
        PersonMatchQuestion(id: 3, question: "Who thinks volunteering enjoys physical benefits?", correctPerson: "Chinua"),
        PersonMatchQuestion(id: 4, question: "Who thinks volunteering should help local communities?", correctPerson: "Boyd"),
        PersonMatchQuestion(id: 5, question: "Who thinks volunteering is good for culture?", correctPerson: "Boyd"),
        PersonMatchQuestion(id: 6, question: "Who thinks volunteering can help advance their career?", correctPerson: "Elly"),
        PersonMatchQuestion(id: 7, question: "Who thinks volunteering is a good reason to travel?", correctPerson: "Chinua"),
    ]

    static let personNames = ["Boyd", "Elly", "Noah", "Chinua"]
}

// MARK: - Part 5: Heading Matching

enum Reading05HeadingMatching {
    static let instruction = "Read the passage quickly. Choose a heading for each numbered paragraph (1–7) from the list. There is one more heading than you need."

    static let passageTitle = "THE 21ST CENTURY CONSUMER AGE"

    static let openingHeading = "The increasing prevalence of a wasteful lifestyle"
    static let openingParagraph = "Modern life often encourages us to replace rather than repair, as convenience has gradually taken priority over long-term value..."

    static let paragraphs: [String] = [
        "It is often said that people today overconsume, but this hasn't always been true. In the past, everyday items such as clothes and shoes were treated as long-term possessions rather than disposable goods...",
        "To explore whether we are overconsuming today, journalist Peter Brown and his wife, Mary Brown, decided to conduct a year-long experiment...",
        "To ensure the success of their challenge, the Browns chose not to inform anyone, including close friends and family. They worried that others might unintentionally interfere...",
        "On May 19, 2003, Mary published a book titled Without Money... It drew attention to issues such as excessive plastic use, unnecessary packaging, and the environmental cost of modern consumption...",
        "One significant challenge the Browns faced was the issue of gift-giving... they decided to create handmade gifts instead. Unfortunately, neither of them had strong artistic skills, so their creations were often imperfect...",
        "Another challenge emerged in relation to Mary's professional life. Her workplace was located far from home... As a compromise, Mary decided to maintain essential work-related expenses while reducing spending in other areas...",
        "The Browns' experiment offers several important lessons for modern society. Firstly, it highlights the need to distinguish clearly between what we truly need and what we simply want..."
    ]

    static let headings: [HeadingOption] = [
        HeadingOption(id: "A", label: "A", text: "A reason for secrecy"),
        HeadingOption(id: "B", label: "B", text: "Important lessons for us all"),
        HeadingOption(id: "C", label: "C", text: "A temporary experiment"),
        HeadingOption(id: "D", label: "D", text: "The difficulty of being generous"),
        HeadingOption(id: "E", label: "E", text: "An unexpected change in plans"),
        HeadingOption(id: "F", label: "F", text: "Still relevant in our times"),
        HeadingOption(id: "G", label: "G", text: "A reason for making a compromise"),
        HeadingOption(id: "H", label: "H", text: "Making things last longer"),
    ]

    static let correctOrder: [String] = ["H", "C", "A", "F", "D", "G", "B"]
}
