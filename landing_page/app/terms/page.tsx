import { Navbar } from "../../components/layout/Navbar";
import { Footer } from "../../components/landing/Footer";

export default function TermsOfService() {
    return (
        <div className="min-h-screen bg-gray-50">
            <Navbar />
            <main className="pt-32 pb-24">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 bg-white p-12 rounded-3xl shadow-sm border border-gray-100">
                    <h1 className="text-4xl font-extrabold text-gray-900 mb-6">Terms of Service</h1>
                    <p className="text-gray-500 mb-10">Last updated: February 2026</p>

                    <div className="prose prose-blue max-w-none text-gray-600">
                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">1. Acceptance of Terms</h2>
                        <p className="mb-6 leading-relaxed">
                            By downloading, installing, or continuing to use the ReadTrack application, you formally agree to adhere to these Terms of Service. If you do not agree with any provision of these terms, you must immediately cease usage of the application and completely uninstall it from your device.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">2. App Usage and Functionality</h2>
                        <p className="mb-6 leading-relaxed">
                            ReadTrack operates strictly as a utility tool for tracking reading time and consistency. The application is provided on an "as is" and "as available" basis. We make NO specific claims, warranties, or guarantees regarding scientific improvement, intellectual growth, memory enhancement, or any other medical/cognitive results resulting from using our software. The functionality is purely a counting metric logging system provided for your personal, non-commercial benefit.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">3. User Data Ownership</h2>
                        <p className="mb-6 leading-relaxed">
                            Because all records, streaks, and settings are physically embedded in your device's local storage and not inherently backed up to our servers, you are solely responsible for maintaining the persistence of this data. Uninstalling the application or structurally modifying your device's operating software may result in an irrecoverable loss of your tracking history. We hold no liability for any lost user logs or disrupted application states.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">4. Intellectual Property Rights</h2>
                        <p className="mb-6 leading-relaxed">
                            The proprietary software, custom graphics, exclusive algorithms, user interface layouts, and generic branding elements contained within ReadTrack are strictly the property of ReadTrack's developers. Any attempts to decompile, reverse engineer, illegally reproduce, redistribute, or commercially replicate the application's unique assets are a gross violation of global intellectual property statutes.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">5. Limitation of Liability</h2>
                        <p className="mb-6 leading-relaxed">
                            To the fullest extent permitted by applicable law, ReadTrack developers inherently isolate themselves from direct, indirect, purely incidental, explicitly unique, or consequential losses, including data damage or perceived habit disruption, resulting from app unreachability, persistent software bugs, or unexpected device interface crashes.
                        </p>
                    </div>
                </div>
            </main>
            <Footer />
        </div>
    );
}
