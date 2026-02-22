export function HowItWorks() {
    const steps = [
        {
            number: "01",
            title: "Read Your Book",
            description: "Spend time reading your physical book, e-reader, or listening to an audiobook. Just focus on your reading.",
        },
        {
            number: "02",
            title: "Log Your Minutes",
            description: "Open ReadTrack when you're done and enter the total number of minutes you spent reading.",
        },
        {
            number: "03",
            title: "Watch Streak Grow",
            description: "See your daily streak increase and your weekly progress bar fill up as you stay consistent.",
        }
    ];

    return (
        <section id="how-it-works" className="py-24 bg-white">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center max-w-3xl mx-auto mb-20">
                    <h2 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">How It Works</h2>
                    <p className="mt-4 text-lg text-gray-600">Three simple steps to building a lasting reading habit.</p>
                </div>
                <div className="grid md:grid-cols-3 gap-12 relative">
                    <div className="hidden md:block absolute top-[40px] left-1/6 right-1/6 border-t-2 border-dashed border-gray-200 z-0"></div>
                    {steps.map((step, idx) => (
                        <div key={idx} className="relative z-10 flex flex-col items-center text-center">
                            <div className="w-20 h-20 bg-blue-600 text-white rounded-2xl flex items-center justify-center text-2xl font-black mb-8 shadow-xl">
                                {step.number}
                            </div>
                            <h3 className="text-xl font-bold text-gray-900 mb-4">{step.title}</h3>
                            <p className="text-gray-600 leading-relaxed max-w-sm">{step.description}</p>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}
