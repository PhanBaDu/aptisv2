import Foundation

enum Reading03Part: Int, CaseIterable, Identifiable {
    case gapFill = 1
    case welcomeOrdering = 2
    case historyOrdering = 3
    case personMatching = 4
    case headingMatching = 5

    var id: Int { rawValue }

    var title: String {
        "Part \(rawValue)"
    }
}

// MARK: - Part 1: Gap Fill

enum Reading03GapFill {
    static let instruction = "Read the email from Jeorge to Luca. Choose one word from the list for each gap. The first one is done for you."

    static let prefix = "Hi Luca,\n\nI'm so excited that you're coming this weekend.\n\nWhen you are at the train "
    static let suffixAfterGap1 = ", go to the main gate.\n\nThe bus "
    static let suffixAfterGap2 = " are near.\n\nMy house is on Parkon Street. It's "
    static let suffixAfterGap3 = ", so you can't miss it.\n\nAfter you come, we will have "
    static let suffixAfterGap4 = ".\n\nIn the evening, we can watch some "
    static let suffixAfterGap5 = " together.\n\nWrite soon,\nJeorge."

    static let gaps: [GapFillItem] = [
        GapFillItem(id: 1, options: ["station", "stationary", "statue"], correctAnswer: "station"),
        GapFillItem(id: 2, options: ["stands", "stops", "sticks"], correctAnswer: "stops"),
        GapFillItem(id: 3, options: ["greet", "green", "greenery"], correctAnswer: "green"),
        GapFillItem(id: 4, options: ["dinner", "dreamer", "dinning"], correctAnswer: "dinner"),
        GapFillItem(id: 5, options: ["fins", "films", "flies"], correctAnswer: "films"),
    ]
}

// MARK: - Part 2 & 3: Sentence Ordering

enum Reading03Ordering {
    static let collegeWelcomingDay = SentenceOrderExercise(
        instruction: "The sentences below are from an instruction. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "College Welcoming Day",
        openingSentence: "Welcome fellow students to North Hemisphere College.",
        sentences: [
            "During this visit, you will need to stay with these students until lunch break.", // A -> 0
            "The day will begin at 10 a.m in the morning with a short presentation.", // B -> 1
            "This meal will be provided on the second floor of the engineering building.", // C -> 2
            "At the end of this talk, you will meet the heads of departments and teachers.", // D -> 3
            "These staff members will give you a guided tour of the buildings and our sports facilities in small groups." // E -> 4
        ],
        // B -> D -> E -> A -> C
        correctOrder: [1, 3, 4, 0, 2]
    )

    static let historyOfTravel = SentenceOrderExercise(
        instruction: "The sentences below are about the history of travel. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "History of Travel",
        openingSentence: "Because flying with them is so fast, more people now go abroad for holiday and business.",
        sentences: [
            "The invention of cars and trains had changed everything and made travelling cheaper.", // A -> 0
            "After these two means of transport, travelling becomes even easier with aeroplanes.", // B -> 1
            "In the past, only very rich people could afford to travel long distances.", // C -> 2
            "It is more convenient to travel to other part of the world due to the improvement in transports.", // D -> 3
            "Because flying with them is so fast, more people now go abroad for holidays and business." // E -> 4
        ],
        // C -> A -> B -> E -> D
        correctOrder: [2, 0, 1, 4, 3]
    )
}

// MARK: - Part 4: Person Matching

enum Reading03PersonMatching {
    static let instruction = "Four people respond in the comments section of an online magazine article about their career paths. Read the texts and then answer the questions below."

    static let people: [PersonPassage] = [
        PersonPassage(
            id: "muhammad",
            name: "Muhammad",
            text: "When I finished school, some people suggested that I should start working straight away to earn money and gain stability. However, I preferred to gain practical experience before making any long-term decisions. For this reason, I applied for several volunteering roles in different organisations. Although I didn't receive any payment, I had the opportunity to explore various fields. Looking back, I feel very satisfied with my choice because I developed useful skills and gained valuable knowledge."
        ),
        PersonPassage(
            id: "oskana",
            name: "Oskana",
            text: "I went straight to university after I graduated from high school. I had always been determined to become a teacher, so wasting time considering other career options was no use for me. Three months ago, I completed an internship at a local school, where I worked with experienced teachers. It was a very eye-opening experience, although the workload was more demanding than I had expected. Despite this, I found the experience extremely rewarding and helpful for my future career."
        ),
        PersonPassage(
            id: "javier",
            name: "Javier",
            text: "As a child, I lived near a plumber and worked with her. She often gave me simple tasks, such as checking for pipe leaks or tightening screws. These early experiences made me interested in practical work, so it felt natural to pursue a degree in electrical work at university. I preferred learning useful, hands-on skills rather than focusing only on anything theoretical. Now that I know that they provide online electrical courses that only last for a couple of months, I sometimes wish I had chosen that alternative instead."
        ),
        PersonPassage(
            id: "antonietta",
            name: "Antonietta",
            text: "After school, I wanted some time to figure out what I wanted to do. Therefore, I started looking for temporary job opportunities to gain some experience. However, it was quite difficult to find a paid position because most companies required previous experience, and I don't want to work for free either. In the end, a game company contacted me, and I decided to accept their offer. The role was partly remote, so I occasionally had to work late in the evenings, but this did not cause any major issues for me."
        ),
    ]

    static let questions: [PersonMatchQuestion] = [
        PersonMatchQuestion(id: 1, question: "Who enjoyed working when training?", correctPerson: "Oskana"),
        PersonMatchQuestion(id: 2, question: "Who thinks it was hard to get the first job?", correctPerson: "Antonietta"),
        PersonMatchQuestion(id: 3, question: "Who benefited from working for free?", correctPerson: "Muhammad"),
        PersonMatchQuestion(id: 4, question: "Who enjoyed working in a flexible work environment?", correctPerson: "Antonietta"),
        PersonMatchQuestion(id: 5, question: "Who did not want to change to other careers?", correctPerson: "Oskana"),
        PersonMatchQuestion(id: 6, question: "Who thinks their training was too long?", correctPerson: "Javier"),
        PersonMatchQuestion(id: 7, question: "Who enjoyed doing things with their hands?", correctPerson: "Javier"),
    ]

    static let personNames = ["Muhammad", "Oskana", "Javier", "Antonietta"]
}

// MARK: - Part 5: Heading Matching

enum Reading03HeadingMatching {
    static let instruction = "Read the passage quickly. Choose a heading for each numbered paragraph (1–7) from the list. There is one more heading than you need."

    static let passageTitle = "WOMAN MATHEMATICS"

    static let openingHeading = "Beyond actual contribution"
    static let openingParagraph = "A historic scientific breakthrough draws global attention, yet the focus is not entirely on the achievement itself..."

    static let paragraphs: [String] = [
        "In 2014, a brilliant mathematician named Leila Farzan surprised the academic world... many reports highlighted her gender as the main point of interest...",
        "Long before Leila's achievement, women had already made substantial and often underappreciated contributions... Isabella Conti, an Italian scholar from the eighteenth century...",
        "Much like her predecessors, Eleanor Hughes, a Cambridge graduate who introduced an innovative theory... Years later, male scientists built upon her ideas and gained widespread recognition...",
        "Confronted with these challenges, Eleanor ultimately withdrew from her academic career... Her last job title was \"Principle Hughes\" of a local college...",
        "Another important reason for this inequality lies in the way language has traditionally been used. Words such as \"genius\" or \"prodigy\" have historically been applied almost exclusively to men...",
        "For decades, the most prestigious awards were overwhelmingly granted to men... organisations have introduced measures such as gender quotas or targeted funding schemes...",
        "In recent efforts to address inequality within scientific fields, the introduction of gender quotas has raised concerns about whether such measures may unintentionally create an advantage..."
    ]

    static let headings: [HeadingOption] = [
        HeadingOption(id: "A", label: "A", text: "Labels can change perspective on people"),
        HeadingOption(id: "B", label: "B", text: "A long career showing exceptional ability"),
        HeadingOption(id: "C", label: "C", text: "Attempting to create a gender balance"),
        HeadingOption(id: "D", label: "D", text: "Gender obscure achievements"),
        HeadingOption(id: "E", label: "E", text: "The difference between male and female scientists"),
        HeadingOption(id: "F", label: "F", text: "Uniformity is not always an advantage"),
        HeadingOption(id: "G", label: "G", text: "Man unfairly credited"),
        HeadingOption(id: "H", label: "H", text: "Acknowledging achievement of a pioneer"),
    ]

    static let correctOrder: [String] = ["D", "H", "G", "B", "A", "C", "F"]
}
