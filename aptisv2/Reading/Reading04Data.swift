import Foundation

enum Reading04Part: Int, CaseIterable, Identifiable {
    case gapFill = 1
    case singerOrdering = 2
    case projectOrdering = 3
    case personMatching = 4
    case headingMatching = 5

    var id: Int { rawValue }

    var title: String {
        "Part \(rawValue)"
    }
}

// MARK: - Part 1: Gap Fill

enum Reading04GapFill {
    static let instruction = "Read the email from Emily to her friend, Sarah. Choose one word from the list for each gap. The first one is done for you."

    static let prefix = "Hi Sarah,\n\nI hope you're doing well.\n\nWe are "
    static let suffixAfterGap1 = " in a house in a small village.\n\nThe house has many trees in its "
    static let suffixAfterGap2 = ".\n\nI went fishing with my "
    static let suffixAfterGap3 = " and it was fun.\n\nWe are going to "
    static let suffixAfterGap4 = " the local town.\n\nThe town has many "
    static let suffixAfterGap5 = " buildings and they have a long history.\n\nThanks,\nEmily."

    static let gaps: [GapFillItem] = [
        GapFillItem(id: 1, options: ["working", "staying", "studying"], correctAnswer: "staying"),
        GapFillItem(id: 2, options: ["garden", "pond", "fountain"], correctAnswer: "garden"),
        GapFillItem(id: 3, options: ["charts", "children", "chillies"], correctAnswer: "children"),
        GapFillItem(id: 4, options: ["visualise", "invite", "visit"], correctAnswer: "visit"),
        GapFillItem(id: 5, options: ["new", "old", "aged"], correctAnswer: "old"),
    ]
}

// MARK: - Part 2 & 3: Sentence Ordering

enum Reading04Ordering {
    static let aSinger = SentenceOrderExercise(
        instruction: "The sentences below are about a singer. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "A Singer",
        openingSentence: "Leo Blucher is a 24-year-old rising artist.",
        sentences: [
            "This strange ways of dressing and his songs attracted people's attention.", // A -> 0
            "Before becoming famous at a young age, he studied art and music at high school.", // B -> 1
            "They started to follow him on social media and he is now very famous.", // C -> 2
            "During his performances on stage, he likes to wear colorful clothes and paint his face.", // D -> 3
            "During this education, he started to perform on stage." // E -> 4
        ],
        // B -> E -> D -> A -> C
        correctOrder: [1, 4, 3, 0, 2]
    )

    static let endTermProject = SentenceOrderExercise(
        instruction: "The sentences below are some school instructions. Put the sentences in the right order. The first sentence is done for you.",
        topicTitle: "End Term Project",
        openingSentence: "You should follow the following guidance for your end of term project.",
        sentences: [
            "After this time, other students are able to ask questions and you need to answer them.", // A -> 0
            "Then you need to use images and written work to create a presentation.", // B -> 1
            "For the end of term project, you need to choose at least two of these.", // C -> 2
            "Your presentation offers your key points and you have around 5 minutes to talk.", // D -> 3
            "It needs to include relevant images and your own text about the topic." // E -> 4
        ],
        // C -> E -> B -> D -> A
        correctOrder: [2, 4, 1, 3, 0]
    )
}

// MARK: - Part 4: Person Matching

enum Reading04PersonMatching {
    static let instruction = "Four people respond in the comments section of an online magazine article about extreme sports. Read the texts and then answer the questions below."

    static let people: [PersonPassage] = [
        PersonPassage(
            id: "bennett",
            name: "Bennett",
            text: "I don't usually like sports, but once I tried sea diving at the invitation of my friends. From that first experience, I quickly became interested in it and wanted to continue learning more. Although extreme sports can be risky, I made sure to prepare carefully before taking it up as a regular hobby. I followed detailed instructions from experts, who taught me important safety techniques. Thanks to this preparation, I gradually improved my skills and felt much more confident while taking part."
        ),
        PersonPassage(
            id: "pierre",
            name: "Pierre",
            text: "Some people like jumping out of aeroplanes or exploring the sea. As a pilot, I have never really understood the appeal of such risky activities. I even tried an extreme sport once, but it only confirmed my original opinion. My job already involves a high level of responsibility and risk, so I do not feel the need to seek additional excitement. Instead, I now prefer more traditional sports like baseball or volleyball, which are safer and help me relax after work."
        ),
        PersonPassage(
            id: "oliver",
            name: "Oliver",
            text: "As a child, I used to do sports because they were part of our school curriculum. Like in most schools, these activities were compulsory, but I never found them enjoyable or interesting. Some students are naturally talented and physically strong, so they perform well in sports, but not everyone has the same abilities. Personally, I found these lessons rather boring and unproductive. I would have preferred spending my time reading books indoors, which I found far more relaxing and meaningful."
        ),
        PersonPassage(
            id: "charlotte",
            name: "Charlotte",
            text: "Doing free-diving requires a lot of patience and effort to become proficient. Since I live quite far from the sea, it is difficult for me to practise this activity on a regular basis. I only get a few opportunities each year, which never feels enough to satisfy my interest. However, whenever I am underwater, I feel calm and completely connected to nature. Being surrounded by different kinds of fish and marine life makes the experience enjoyable, peaceful, and truly unforgettable for me."
        ),
    ]

    static let questions: [PersonMatchQuestion] = [
        PersonMatchQuestion(id: 1, question: "Who prefers traditional sports?", correctPerson: "Pierre"),
        PersonMatchQuestion(id: 2, question: "Who enjoys nature while doing sports?", correctPerson: "Charlotte"),
        PersonMatchQuestion(id: 3, question: "Who thinks training is important before doing extreme sports?", correctPerson: "Bennett"),
        PersonMatchQuestion(id: 4, question: "Who avoids doing any sports?", correctPerson: "Oliver"),
        PersonMatchQuestion(id: 5, question: "Who thinks extreme sports are not necessary for them?", correctPerson: "Pierre"),
        PersonMatchQuestion(id: 6, question: "Who wishes they are able to do extreme sports more often?", correctPerson: "Charlotte"),
        PersonMatchQuestion(id: 7, question: "Who enjoys doing extreme sports after first attempt?", correctPerson: "Bennett"),
    ]

    static let personNames = ["Bennett", "Pierre", "Oliver", "Charlotte"]
}

// MARK: - Part 5: Heading Matching

enum Reading04HeadingMatching {
    static let instruction = "Read the passage quickly. Choose a heading for each numbered paragraph (1–7) from the list. There is one more heading than you need."

    static let passageTitle = "BIOGRAPHY OF CHARLES DICKENS"

    static let openingHeading = "A notable name among many"
    static let openingParagraph = "Some literary works continue to attract attention long after they were first written, appearing in new forms across different generations..."

    static let paragraphs: [String] = [
        "Charles Dickens was born into a modest family in 1812... Figures like Oliver Twist or Scrooge have become familiar references in everyday language and culture...",
        "Although Dickens's stories are still widely known, the significant length of his novels make many contemporary readers hesitate to engage...",
        "The way Dickens's stories were first presented to readers played an important role in their success... released in smaller sections over time... often ending at a moment of tension or uncertainty...",
        "In contrast to the admiration and respect he receives today, Dickens's work did not receive much acclaim during his own time. The contemporary media often regarded his prolific output as excessive...",
        "At the beginning of his career, Dickens did not immediately set out to become one of the most celebrated novelists of his era... readers responded enthusiastically to his storytelling, and the narrative quickly gained popularity...",
        "As Dickens's reputation grew, so did the challenges associated with intellectual property... his stories were frequently copied or adapted without permission...",
        "Over time, Dickens's stories have continued to reach new audiences through a variety of creative forms. Directors and producers have found his narratives especially suitable for adaptation..."
    ]

    static let headings: [HeadingOption] = [
        HeadingOption(id: "A", label: "A", text: "Bringing the book to life"),
        HeadingOption(id: "B", label: "B", text: "Difficulties of modern readers"),
        HeadingOption(id: "C", label: "C", text: "Lessons for the young generation"),
        HeadingOption(id: "D", label: "D", text: "Dickens' early success"),
        HeadingOption(id: "E", label: "E", text: "Influence of the media"),
        HeadingOption(id: "F", label: "F", text: "Trying to protect his property"),
        HeadingOption(id: "G", label: "G", text: "Charles Dickens for our times"),
        HeadingOption(id: "H", label: "H", text: "Keeping readers guessing"),
    ]

    static let correctOrder: [String] = ["G", "B", "H", "E", "D", "F", "A"]
}
