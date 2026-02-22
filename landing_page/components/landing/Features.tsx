import { BookOpen, Calendar, Flame, Target } from "lucide-react";

export function Features() {
    const features = [
        {
            title: "Log Your Minutes",
            description: "Quickly enter the number of minutes you read each day. A simple number to track your journey without unnecessary complication.",
            icon: <BookOpen className="w-6 h-6 text-blue-600" />
        },
        {
            title: "Build Your Streak",
            description: "Keep the streak alive by reading daily. If you read, your streak grows. Skip a day, it resets. A powerful visual motivator.",
            icon: <Flame className="w-6 h-6 text-orange-500" />
        },
        {
            title: "Weekly Consistency",
            description: "Review a clean 7-day overview of your reading habits. See exactly which days you read and the total minutes accumulated.",
            icon: <Calendar className="w-6 h-6 text-purple-600" />
        },
        {
            title: "Daily Goals",
            description: "Set a simple daily target, like 20 minutes, and watch your progress bar fill up. No complex charts, just pure focused consistency.",
            icon: <Target className="w-6 h-6 text-green-600" />
        }
    ];

    return (
        <section id="features" className="py-24 bg-gray-50">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center max-w-3xl mx-auto mb-16">
                    <h2 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Everything You Need, Nothing You Don't</h2>
                    <p className="mt-4 text-lg text-gray-600">
                        ReadTrack is intentionally designed without distractions. No social feeds, no complex databases or text summaries—just your reading habit, simplified.
                    </p>
                </div>
                <div className="grid md:grid-cols-2 gap-12">
                    {features.map((feature, idx) => (
                        <div key={idx} className="bg-white rounded-2xl p-8 shadow-sm border border-gray-100 flex gap-6 hover:shadow-md transition-shadow">
                            <div className="flex-shrink-0 bg-gray-50 w-14 h-14 flex items-center justify-center rounded-xl">
                                {feature.icon}
                            </div>
                            <div>
                                <h3 className="text-xl font-semibold text-gray-900 mb-2">{feature.title}</h3>
                                <p className="text-gray-600 leading-relaxed">{feature.description}</p>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}
