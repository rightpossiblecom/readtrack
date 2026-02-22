import { Navbar } from "../../components/layout/Navbar";
import { Footer } from "../../components/landing/Footer";
import { Mail, MessageSquare, Twitter } from "lucide-react";

export default function Contact() {
    return (
        <div className="min-h-screen bg-gray-50">
            <Navbar />
            <main className="pt-32 pb-24">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center mb-16">
                        <h1 className="text-4xl font-extrabold text-gray-900 mb-4">Contact Us</h1>
                        <p className="text-xl text-gray-600">Have a question or feedback? We'd love to hear from you.</p>
                    </div>

                    <div className="grid md:grid-cols-2 gap-8">
                        <div className="bg-white p-8 rounded-3xl shadow-sm border border-gray-100 flex flex-col items-center text-center">
                            <div className="w-16 h-16 bg-blue-50 text-blue-600 rounded-full flex items-center justify-center mb-6">
                                <Mail className="w-8 h-8" />
                            </div>
                            <h3 className="text-2xl font-bold text-gray-900 mb-2">Email Support</h3>
                            <p className="text-gray-600 mb-6">For general inquiries, feature requests, or technical support, drop us an email.</p>
                            <a href="mailto:support@readtrack.app" className="text-blue-600 font-semibold hover:text-blue-700 transition-colors text-lg">
                                support@readtrack.app
                            </a>
                        </div>

                        <div className="bg-white p-8 rounded-3xl shadow-sm border border-gray-100 flex flex-col items-center text-center">
                            <div className="w-16 h-16 bg-blue-50 text-blue-600 rounded-full flex items-center justify-center mb-6">
                                <Twitter className="w-8 h-8" />
                            </div>
                            <h3 className="text-2xl font-bold text-gray-900 mb-2">Social Media</h3>
                            <p className="text-gray-600 mb-6">Follow our updates, share your streaks, and connect with other readers.</p>
                            <a href="https://twitter.com/ReadTrackApp" target="_blank" rel="noopener noreferrer" className="text-blue-600 font-semibold hover:text-blue-700 transition-colors text-lg">
                                @ReadTrackApp
                            </a>
                        </div>
                    </div>
                </div>
            </main>
            <Footer />
        </div>
    );
}
