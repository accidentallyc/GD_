extends SimpleTest

func it_should_work_with_compound_words():
    expect(GD_.words('12ft')).equal(['12', 'ft'])
    expect(GD_.words('aeiouAreVowels')).equal(['aeiou', 'Are', 'Vowels'])
    expect(GD_.words('enable 6h format')).equal(['enable', '6', 'h', 'format'])
    expect(GD_.words('enable 24H format')).equal(['enable', '24', 'H', 'format'])
    expect(GD_.words('isISO8601')).equal(['is', 'ISO', '8601'])
    expect(GD_.words('LETTERSAeiouAreVowels')).equal(['LETTERS', 'Aeiou', 'Are', 'Vowels'])
    expect(GD_.words('tooLegit2Quit')).equal(['too', 'Legit', '2', 'Quit'])
    expect(GD_.words('walk500Miles')).equal(['walk', '500', 'Miles'])
    expect(GD_.words('xhr2Request')).equal(['xhr', '2', 'Request'])
    expect(GD_.words('XMLHttp')).equal(['XML', 'Http'])
    expect(GD_.words('XmlHTTP')).equal(['Xml', 'HTTP'])
    expect(GD_.words('XmlHttp')).equal(['Xml', 'Http'])
    
func it_should_work_with_compound_words_containing_diacritical_marks():
    expect(GD_.words('LETTERSÆiouAreVowels')).equal(['LETTERS', 'Æiou', 'Are', 'Vowels'])
    expect(GD_.words('æiouAreVowels')).equal(['æiou', 'Are', 'Vowels'])
    expect(GD_.words('æiou2Consonants')).equal(['æiou', '2', 'Consonants'])
    
func it_should_not_treat_contractions_as_separate_words():
    var postfixes = ['d', 'll', 'm', 're', 's', 't', 've']
 
    expect(GD_.words("He'd forgotten already.")).equal(["He'd","forgotten","already"])
    expect(GD_.words("We'll see soon.")).equal(["We'll","see","soon"])
    expect(GD_.words("I'm coming now.")).equal(["I'm","coming","now"])
    expect(GD_.words("You're right here.")).equal(["You're","right","here"])
    expect(GD_.words("It's really cold.")).equal(["It's","really","cold"])
    expect(GD_.words("Can't help it.")).equal(["Can't","help","it"])
    expect(GD_.words("I've seen it.")).equal(["I've","seen","it"])

func it_should_not_treat_ordinal_numbers_as_separate_words():
    var ordinals = ['1st', '2nd', '3rd', '4th', '21st']

    for ordinal in ordinals:
        expect(GD_.words("You are %s" % ordinal)).to.equal(["You","are",ordinal])

func it_should_not_treat_math_symbols_as_words():
    expect(GD_.words("three ÷ six")).equal(["three","six"])
    expect(GD_.words("three ± six")).equal(["three","six"])
    expect(GD_.words("three × six")).equal(["three","six"])
    expect(GD_.words("¬A")).equal(["A"])

func it_should_prevent_regex_dos():
    var largeWordLen = 50000
    var largeWord = 'A'.repeat(largeWordLen)
    var maxMs = 1000

    var input = str(largeWord,"ÆiouAreVowels")
    var startTime = Time.get_ticks_msec()
    expect(GD_.words(input)).equal([largeWord, 'Æiou', 'Are', 'Vowels'])
    
    var endTime = Time.get_ticks_msec()
    var timeSpent = endTime - startTime

    expect(timeSpent).to.be.lte(maxMs)
    
func it_accepts_emojis():
    expect(GD_.words("oh yes 🍆💦💥")).equal(['oh', 'yes', '🍆', '💦', '💥'])

func it_can_be_used_as_an_iterator():
    var input = [
        "hello world",
        "I've seen it.",
        "aeiouAreVowels"
    ]
    var outputs = [
        ["hello","world"],
        ["I've","seen","it"],
        ['aeiou', 'Are', 'Vowels']
    ]
    var result = GD_.map(input, GD_.words)
    expect(result).to.equal(outputs)

func it_accepts_custom_pattern():
    expect(GD_.words('fred, barney, & pebbles', "[^, ]+")).to.equal(['fred', 'barney', '&', 'pebbles'])
    expect(GD_.words('fred, barney, & pebbles', RegEx.create_from_string("[^, ]+"))).to.equal(['fred', 'barney', '&', 'pebbles'])

