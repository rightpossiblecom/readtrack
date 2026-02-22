import { Navbar } from "../../components/layout/Navbar";
import { Footer } from "../../components/landing/Footer";

export default function PrivacyPolicy() {
    return (
        <div className="min-h-screen bg-gray-50">
            <Navbar />
            <main className="pt-32 pb-24">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 bg-white p-12 rounded-3xl shadow-sm border border-gray-100">
                    <h1 className="text-4xl font-extrabold text-gray-900 mb-6">Privacy Policy</h1>
                    <p className="text-gray-500 mb-10">Last updated: February 2026</p>

                    <div className="prose prose-blue max-w-none text-gray-600">
                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">1. Introduction</h2>
                        <p className="mb-6 leading-relaxed">
                            At ReadTrack, your privacy is our top priority. We believe that tracking your personal reading habits should be a completely private and secure experience. This Privacy Policy details our unwavering commitment to maintaining the confidentiality of your data. ReadTrack is designed with local storage principles, meaning we fundamentally eliminate many privacy risks by design.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">2. Data Collection & Local Storage</h2>
                        <p className="mb-6 leading-relaxed">
                            <strong>Local Only:</strong> ReadTrack does not require account creation, sign-ins, or cloud synchronization. All data you enter into the application, including your daily reading minutes, current streaks, and historical habit logs, is stored securely and entirely locally on your physical device. We do not transmit your habit data to external servers, ensuring you retain total control over your personal information.
                            <br /><br />
                            <strong>No Telemetry:</strong> We do not embed hidden tracking scripts or analytic SDKs within our mobile application that would siphon your personal reading data to our company or any third parties.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">3. Device Permissions</h2>
                        <p className="mb-6 leading-relaxed">
                            ReadTrack operates incredibly efficiently and requests only the minimal permissions required for its localized functioning. We do not request access to your contacts, camera, location services, or external storage not explicitly linked to the app's core operations.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">4. Third-Party Access</h2>
                        <p className="mb-6 leading-relaxed">
                            Because your personal reading data never leaves your device, we cannot, and do not, sell or distribute your data to third-party advertising networks, data brokers, or marketing firms.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">5. Revisions</h2>
                        <p className="mb-6 leading-relaxed">
                            We may periodically update this Privacy Policy. Due to our local-only architecture, we cannot notify users directly through an account system. We encourage you to review this document occasionally to ensure you remain comfortable with our ongoing privacy practices. Any changes will be recorded here and reflected by the "Last updated" timestamp above.
                        </p>

                        <h2 className="text-2xl font-bold text-gray-900 mt-10 mb-4">6. Contact Information</h2>
                        <p className="mb-6 leading-relaxed">
                            If you have any questions or concerns regarding this Privacy Policy or how ReadTrack handles privacy issues, please reach out to us directly via our support channels clearly outlined on our Contact page or at support@readtrack.app.
                        </p>
                    </div>
                </div>
            </main>
            <Footer />
        </div>
    );
}
