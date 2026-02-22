import { AppScreen } from "../mockup/AppScreen";

export function Hero() {
    return (
        <section className="relative pt-32 pb-20 lg:pt-48 lg:pb-32 overflow-hidden bg-white">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                <div className="text-center max-w-3xl mx-auto">
                    <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-sm font-medium mb-8">
                        <span className="flex h-2 w-2 rounded-full bg-blue-600"></span>
                        Simple daily tracking
                    </div>
                    <h1 className="text-5xl lg:text-7xl font-extrabold tracking-tight text-gray-900 mb-8 leading-tight">
                        Build a consistent <br /><span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-600">reading habit</span>
                    </h1>
                    <p className="text-xl text-gray-600 mb-10 leading-relaxed max-w-2xl mx-auto">
                        ReadTrack is the simplest way to track your daily reading minutes and maintain your streak. No distractions, just consistency.
                    </p>
                    <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
                        <button className="w-full sm:w-auto px-8 py-4 text-lg font-semibold text-white bg-blue-600 rounded-full hover:bg-blue-700 shadow-lg hover:shadow-xl transition-all">
                            Download for Android
                        </button>
                        <button className="w-full sm:w-auto px-8 py-4 text-lg font-semibold text-gray-700 bg-white border-2 border-gray-200 rounded-full hover:border-gray-300 hover:bg-gray-50 transition-all">
                            Download for iOS
                        </button>
                    </div>
                </div>
            </div>
            <div className="mt-20 mx-auto max-w-lg lg:max-w-4xl px-4 sm:px-6">
                <AppScreen />
            </div>
        </section>
    );
}
