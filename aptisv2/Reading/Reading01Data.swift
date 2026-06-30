import Foundation

enum Reading01Part: Int, CaseIterable, Identifiable {
    case gapFill = 1
    case filmOrdering = 2
    case sportOrdering = 3
    case personMatching = 4
    case headingMatching = 5

    var id: Int { rawValue }

    var title: String {
        "Part \(rawValue)"
    }
}

// MARK: - Part 1: Gap Fill

struct GapFillItem: Identifiable {
    let id: Int
    let options: [String]
    let correctAnswer: String
}

enum Reading01GapFill {
    static let instruction = "Read the email from Anna to her parents. Choose one word from the list for each gap. The first one is done for you."

    static let prefix = "Dear Dad and Mom,\n\nIt's been a while since I last wrote to you.\n\nI "
    static let suffixAfterGap1 = " the beautiful area where I live now.\n\nI have a lovely kitchen, but it's very "
    static let suffixAfterGap2 = ".\n\nI work at a "
    static let suffixAfterGap3 = " and I sell clothes,\n\nEveryday, I talk to many "
    static let suffixAfterGap4 = "\n\nI am on my holiday and I am excited that I can "
    static let suffixAfterGap5 = " you soon.\n\nLove,\nAnna"

    static let gaps: [GapFillItem] = [
        GapFillItem(id: 1, options: ["love", "hate", "tired"], correctAnswer: "love"),
        GapFillItem(id: 2, options: ["messy", "small", "dirty"], correctAnswer: "small"),
        GapFillItem(id: 3, options: ["cafe", "garden", "shop"], correctAnswer: "shop"),
        GapFillItem(id: 4, options: ["people", "animals", "trees"], correctAnswer: "people"),
        GapFillItem(id: 5, options: ["walk", "visit", "close"], correctAnswer: "visit"),
    ]
}

// MARK: - Part 2 & 3: Sentence Ordering

struct SentenceOrderExercise {
    let instruction: String
    let topicTitle: String
    let openingSentence: String
    let sentences: [String]
    let correctOrder: [Int]
}

enum Reading01Ordering {
    static let filmMaking = SentenceOrderExercise(
        instruction: "The sentences below are the history of film making. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "Making films",
        openingSentence: "In the 1800s, movies were first invented and appeared in cinema.",
        sentences: [
            "This lack of money mostly affected actors, and they didn't earn much.",
            "This is because they were black and white, and there was no sound.",
            "Things have changed over time, and some of them have earned millions of dollars after appearing in films.",
            "The films in that period were different from the films of today.",
            "In addition to these technical limitations, film producers also had a very low budget.",
        ],
        correctOrder: [3, 1, 4, 0, 2]
    )

    static let familySportDay = SentenceOrderExercise(
        instruction: "The sentences below are from the local news on the family sport day event. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "Family Sport day",
        openingSentence: "The sport day event last week captured local attention.",
        sentences: [
            "After receiving the prize, the children's activities and competitions began.",
            "It started early on Saturday morning with a ten-mile race for adults.",
            "They were all very hungry after all these, so they enjoyed tasty food and drinks with their parents.",
            "Sixty men and women ran in this, and Ms Kamur won with a very fast time.",
            "These activities included football, jumping, and swimming, and they had lots of fun.",
        ],
        correctOrder: [1, 3, 0, 4, 2]
    )
}

// MARK: - Part 4: Person Matching

struct PersonPassage: Identifiable {
    let id: String
    let name: String
    let text: String
}

struct PersonMatchQuestion: Identifiable {
    let id: Int
    let question: String
    let correctPerson: String
}

enum Reading01PersonMatching {
    static let instruction = "Four people respond in the comments section of an online magazine article about their childhood activities. Read the texts and then answer the questions below."

    static let people: [PersonPassage] = [
        PersonPassage(
            id: "shelly",
            name: "Shelly",
            text: "I enjoyed playing outdoors with other friends. When the day was gloomy, as it often was where I lived, I looked out of my window and hoped it would stop. There wasn't much I could do inside the house. My parents often gave me books, but I never liked sitting stills and reading. Until one day my mother brought me a box full of art supplies. That's when I realized there was another thing I loved—painting. I could spend hours just staring at a blank canvas, wondering what to draw next."
        ),
        PersonPassage(
            id: "jan",
            name: "Jan",
            text: "I wasn't able to move much as a child and even now. I mostly stayed at home since I don't have many friends. I was drawn to books and imagined myself as the main character on his adventurous journeys discovering unnamed lands. There was a library I often visited with my close friend, and we would get completely lost in the stories. Now, I don't read as much as I used to, but I don't go out very often either. Instead, I spend time on my computer, where I can play games. I prefer interactive ones because they let me socialize with people online."
        ),
        PersonPassage(
            id: "odilia",
            name: "Odilia",
            text: "As a child, I spent hours playing board games with my friends. The rules were pretty straightforward and easy to understand. As I grew older, I thought it would be a great chance for families to bond in this way. However, modern board games were much more difficult, with so many rules and characters to choose from. Although I did have a great time with my two sons and we often laughed while playing, it was still a bit of an effort to learn how to play."
        ),
        PersonPassage(
            id: "chris",
            name: "Chris",
            text: "I preferred to play outdoors with my friends rather than staying inside with a good book when I was small. The weather where we lived was usually nice, so we often ran around with a ball and chased each other in the field. Sometimes, we lay on the grass, made funny faces, and looked up at the blue sky, wondering who we would become when we grew up. All of these memories were just wonderful, and they made me realize how much I enjoy being around people. Even today, I find it hard to stay home alone."
        ),
    ]

    static let questions: [PersonMatchQuestion] = [
        PersonMatchQuestion(id: 1, question: "Who enjoyed doing arts as a child?", correctPerson: "Shelly"),
        PersonMatchQuestion(id: 2, question: "Who preferred reading books as a child?", correctPerson: "Jan"),
        PersonMatchQuestion(id: 3, question: "Who enjoyed playing games with their children?", correctPerson: "Odilia"),
        PersonMatchQuestion(id: 4, question: "Who wished they could spend more time outdoors?", correctPerson: "Shelly"),
        PersonMatchQuestion(id: 5, question: "Who enjoyed playing with other children as a child?", correctPerson: "Chris"),
        PersonMatchQuestion(id: 6, question: "Who enjoyed playing modern games?", correctPerson: "Jan"),
        PersonMatchQuestion(id: 7, question: "Who thought traditional games were much simpler?", correctPerson: "Odilia"),
    ]

    static let personNames = ["Shelly", "Jan", "Odilia", "Chris"]
}

// MARK: - Part 5: Heading Matching (ordering-style selection)

struct HeadingOption: Identifiable {
    let id: String
    let label: String
    let text: String
}

enum Reading01HeadingMatching {
    static let instruction = "Read the passage quickly. Choose a heading for each numbered paragraph (1–7) from the list. There is one more heading than you need."

    static let passageTitle = "MOUNTAIN SUMMITS"

    static let openingHeading = "The attraction of a geographical terrain"
    static let openingParagraph = "For centuries, mountains were admired not as challenges to conquer, but as places of beauty and quiet reflection. Early travellers were drawn by curiosity rather than ambition. The journey itself, rather than the destination, was what truly mattered."

    static let paragraphs: [String] = [
        "Even before the nineteenth century, mountains had always fascinated travelers and explorers. Their towering presence and untouched beauty naturally drew people in, offering a sense of mystery and wonder that was difficult to find elsewhere. For early adventurers, climbing to the summit was not driven by competition or recognition, but by curiosity and the simple desire to witness breathtaking views from above. Reaching the top provided a unique perspective of the surrounding landscape, making the effort worthwhile. In modern times, however, mountain peaks continue to attract large numbers of visitors.",
        "For a significant number of climbers, reaching the summit now carries a deeper symbolic meaning that goes beyond the physical act itself. The idea of the \"summit\" is often used as a metaphor for achieving success in life, while the difficulties encountered along the climb are interpreted as personal struggles or obstacles that must be overcome. Over time, mountaineering has evolved into more than just an outdoor activity; it has developed into a cultural pursuit associated with adventure, endurance, and self-discovery. In this context, the emphasis has gradually shifted away from the journey and toward the final result.",
        "The concept of climbing as an \"achievement\" has become even more meaningful with the rise of what is commonly known as the \"summit selfie.\" Even before the emergence of social media, taking a photograph at the top of a mountain was considered an important and memorable part of the experience. Initially, these photos served as personal keepsakes—simple reminders of a meaningful journey. Over time, they have also become a powerful way to share and inspire others. With the rapid growth of social networking platforms, this trend has expanded significantly, allowing climbers to connect with wider audiences and celebrate their achievements together. For many, capturing a moment at the summit enhances the sense of pride and provides lasting motivation.",
        "Critics of this modern approach argue that while reaching the summit remains an appealing goal, the motive behind it has become increasingly superficial. For some participants, neither the journey nor the genuine experience of reaching the top holds real significance. In retrospect, climbing a mountain requires careful preparation in multiple areas, including physical training, financial planning, and logistical coordination. These elements are essential to ensure both safety and success, yet often neglected by the majority. Instead of being a challenging and rewarding endeavour, it risks becoming a shallow pursuit driven by external validation.",
        "A striking example that highlights the changing nature of mountaineering can be found in a photograph taken by Ethan Crawford in 1993. The image captured a long line of climbers waiting to reach the summit, a scene that sharply contrasts with the traditional image of solitary exploration. What was once an activity reserved for determined adventurers had begun to resemble a crowded, almost commercial experience. Rather than showing excitement or a sense of achievement, many of the climbers in the photograph appeared tired, frustrated, and impatient. When the image was later widely shared, it sparked considerable debate about the true purpose of climbing. People began to question whether mountaineering had lost its original spirit of exploration and discovery, or whether it had been transformed into a competitive activity focused on status and recognition.",
        "In response to these concerns, many argue that the current trend-driven approach to climbing should be reconsidered. Activists and environmentalists emphasise the importance of responsible climbing practices, encouraging individuals to respect nature and minimise their impact. They argue that regardless of personal ambitions, reaching the summit is only meaningful if the journey is conducted in a way that is sustainable and respectful. If the process involves harming the environment or disregarding the natural surroundings, then the achievement itself loses much of its value and significance.",
        "Given these developments, it may be time to rethink how mountaineering is approached and to return to its original spirit. In her memoir, Charlie Bennett reflects on her own experience of climbing, describing it as an opportunity to slow down and reconnect with the natural world. Instead, it was about moving at a gentle pace, allowing the mountain to guide the experience, and finding joy in simply being present. Each step offered a moment for reflection and a chance to appreciate the surrounding environment. This perspective highlights a different understanding of mountaineering—one that values mindfulness, connection, and personal meaning over achievement. Ultimately, it suggests that the true essence of climbing lies not in conquering the summit, but in appreciating the journey itself.",
    ]

    static let headings: [HeadingOption] = [
        HeadingOption(id: "A", label: "A", text: "A more intimate relationship"),
        HeadingOption(id: "B", label: "B", text: "Publicising one's achievements"),
        HeadingOption(id: "C", label: "C", text: "Our changing definition of mountains"),
        HeadingOption(id: "D", label: "D", text: "The wrong priority"),
        HeadingOption(id: "E", label: "E", text: "The history of mountains"),
        HeadingOption(id: "F", label: "F", text: "A focus on sustainability"),
        HeadingOption(id: "G", label: "G", text: "A unique sense of achievement"),
        HeadingOption(id: "H", label: "H", text: "A disturbing revelation"),
    ]

    /// Correct heading id for paragraphs 1–7
    static let correctOrder: [String] = ["C", "G", "B", "D", "H", "F", "A"]
}
