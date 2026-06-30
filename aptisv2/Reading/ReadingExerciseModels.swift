import Foundation

struct GapFillExercise {
    let instruction: String
    let prefix: String
    let suffixAfterGap1: String
    let suffixAfterGap2: String
    let suffixAfterGap3: String
    let suffixAfterGap4: String
    let suffixAfterGap5: String
    let gaps: [GapFillItem]
}

struct PersonMatchingExercise {
    let instruction: String
    let people: [PersonPassage]
    let questions: [PersonMatchQuestion]
    let personNames: [String]
}

struct HeadingMatchingExercise {
    let instruction: String
    let passageTitle: String
    let openingHeading: String
    let openingParagraph: String
    let paragraphs: [String]
    let headings: [HeadingOption]
    let correctOrder: [String]
}

struct ReadingExamData {
    let gapFill: GapFillExercise
    let orderingPart2: SentenceOrderExercise
    let orderingPart3: SentenceOrderExercise
    let personMatching: PersonMatchingExercise
    let headingMatching: HeadingMatchingExercise
    
    static func forExam(_ index: Int) -> ReadingExamData {
        switch index {
        case 1:
            return ReadingExamData(
                gapFill: GapFillExercise(
                    instruction: Reading01GapFill.instruction,
                    prefix: Reading01GapFill.prefix,
                    suffixAfterGap1: Reading01GapFill.suffixAfterGap1,
                    suffixAfterGap2: Reading01GapFill.suffixAfterGap2,
                    suffixAfterGap3: Reading01GapFill.suffixAfterGap3,
                    suffixAfterGap4: Reading01GapFill.suffixAfterGap4,
                    suffixAfterGap5: Reading01GapFill.suffixAfterGap5,
                    gaps: Reading01GapFill.gaps
                ),
                orderingPart2: Reading01Ordering.filmMaking,
                orderingPart3: Reading01Ordering.familySportDay,
                personMatching: PersonMatchingExercise(
                    instruction: Reading01PersonMatching.instruction,
                    people: Reading01PersonMatching.people,
                    questions: Reading01PersonMatching.questions,
                    personNames: Reading01PersonMatching.personNames
                ),
                headingMatching: HeadingMatchingExercise(
                    instruction: Reading01HeadingMatching.instruction,
                    passageTitle: Reading01HeadingMatching.passageTitle,
                    openingHeading: Reading01HeadingMatching.openingHeading,
                    openingParagraph: Reading01HeadingMatching.openingParagraph,
                    paragraphs: Reading01HeadingMatching.paragraphs,
                    headings: Reading01HeadingMatching.headings,
                    correctOrder: Reading01HeadingMatching.correctOrder
                )
            )
        case 2:
            return ReadingExamData(
                gapFill: GapFillExercise(
                    instruction: Reading02GapFill.instruction,
                    prefix: Reading02GapFill.prefix,
                    suffixAfterGap1: Reading02GapFill.suffixAfterGap1,
                    suffixAfterGap2: Reading02GapFill.suffixAfterGap2,
                    suffixAfterGap3: Reading02GapFill.suffixAfterGap3,
                    suffixAfterGap4: Reading02GapFill.suffixAfterGap4,
                    suffixAfterGap5: Reading02GapFill.suffixAfterGap5,
                    gaps: Reading02GapFill.gaps
                ),
                orderingPart2: Reading02Ordering.firstAmericanWoman,
                orderingPart3: Reading02Ordering.musicShow,
                personMatching: PersonMatchingExercise(
                    instruction: Reading02PersonMatching.instruction,
                    people: Reading02PersonMatching.people,
                    questions: Reading02PersonMatching.questions,
                    personNames: Reading02PersonMatching.personNames
                ),
                headingMatching: HeadingMatchingExercise(
                    instruction: Reading02HeadingMatching.instruction,
                    passageTitle: Reading02HeadingMatching.passageTitle,
                    openingHeading: Reading02HeadingMatching.openingHeading,
                    openingParagraph: Reading02HeadingMatching.openingParagraph,
                    paragraphs: Reading02HeadingMatching.paragraphs,
                    headings: Reading02HeadingMatching.headings,
                    correctOrder: Reading02HeadingMatching.correctOrder
                )
            )
        case 3:
            return ReadingExamData(
                gapFill: GapFillExercise(
                    instruction: Reading03GapFill.instruction,
                    prefix: Reading03GapFill.prefix,
                    suffixAfterGap1: Reading03GapFill.suffixAfterGap1,
                    suffixAfterGap2: Reading03GapFill.suffixAfterGap2,
                    suffixAfterGap3: Reading03GapFill.suffixAfterGap3,
                    suffixAfterGap4: Reading03GapFill.suffixAfterGap4,
                    suffixAfterGap5: Reading03GapFill.suffixAfterGap5,
                    gaps: Reading03GapFill.gaps
                ),
                orderingPart2: Reading03Ordering.collegeWelcomingDay,
                orderingPart3: Reading03Ordering.historyOfTravel,
                personMatching: PersonMatchingExercise(
                    instruction: Reading03PersonMatching.instruction,
                    people: Reading03PersonMatching.people,
                    questions: Reading03PersonMatching.questions,
                    personNames: Reading03PersonMatching.personNames
                ),
                headingMatching: HeadingMatchingExercise(
                    instruction: Reading03HeadingMatching.instruction,
                    passageTitle: Reading03HeadingMatching.passageTitle,
                    openingHeading: Reading03HeadingMatching.openingHeading,
                    openingParagraph: Reading03HeadingMatching.openingParagraph,
                    paragraphs: Reading03HeadingMatching.paragraphs,
                    headings: Reading03HeadingMatching.headings,
                    correctOrder: Reading03HeadingMatching.correctOrder
                )
            )
        case 4:
            return ReadingExamData(
                gapFill: GapFillExercise(
                    instruction: Reading04GapFill.instruction,
                    prefix: Reading04GapFill.prefix,
                    suffixAfterGap1: Reading04GapFill.suffixAfterGap1,
                    suffixAfterGap2: Reading04GapFill.suffixAfterGap2,
                    suffixAfterGap3: Reading04GapFill.suffixAfterGap3,
                    suffixAfterGap4: Reading04GapFill.suffixAfterGap4,
                    suffixAfterGap5: Reading04GapFill.suffixAfterGap5,
                    gaps: Reading04GapFill.gaps
                ),
                orderingPart2: Reading04Ordering.aSinger,
                orderingPart3: Reading04Ordering.endTermProject,
                personMatching: PersonMatchingExercise(
                    instruction: Reading04PersonMatching.instruction,
                    people: Reading04PersonMatching.people,
                    questions: Reading04PersonMatching.questions,
                    personNames: Reading04PersonMatching.personNames
                ),
                headingMatching: HeadingMatchingExercise(
                    instruction: Reading04HeadingMatching.instruction,
                    passageTitle: Reading04HeadingMatching.passageTitle,
                    openingHeading: Reading04HeadingMatching.openingHeading,
                    openingParagraph: Reading04HeadingMatching.openingParagraph,
                    paragraphs: Reading04HeadingMatching.paragraphs,
                    headings: Reading04HeadingMatching.headings,
                    correctOrder: Reading04HeadingMatching.correctOrder
                )
            )
        case 5:
            return ReadingExamData(
                gapFill: GapFillExercise(
                    instruction: Reading05GapFill.instruction,
                    prefix: Reading05GapFill.prefix,
                    suffixAfterGap1: Reading05GapFill.suffixAfterGap1,
                    suffixAfterGap2: Reading05GapFill.suffixAfterGap2,
                    suffixAfterGap3: Reading05GapFill.suffixAfterGap3,
                    suffixAfterGap4: Reading05GapFill.suffixAfterGap4,
                    suffixAfterGap5: Reading05GapFill.suffixAfterGap5,
                    gaps: Reading05GapFill.gaps
                ),
                orderingPart2: Reading05Ordering.newCafeInTown,
                orderingPart3: Reading05Ordering.homeworkNextWeek,
                personMatching: PersonMatchingExercise(
                    instruction: Reading05PersonMatching.instruction,
                    people: Reading05PersonMatching.people,
                    questions: Reading05PersonMatching.questions,
                    personNames: Reading05PersonMatching.personNames
                ),
                headingMatching: HeadingMatchingExercise(
                    instruction: Reading05HeadingMatching.instruction,
                    passageTitle: Reading05HeadingMatching.passageTitle,
                    openingHeading: Reading05HeadingMatching.openingHeading,
                    openingParagraph: Reading05HeadingMatching.openingParagraph,
                    paragraphs: Reading05HeadingMatching.paragraphs,
                    headings: Reading05HeadingMatching.headings,
                    correctOrder: Reading05HeadingMatching.correctOrder
                )
            )
        default:
            fatalError("Invalid exam index")
        }
    }
}
