import { Navbar } from "../../components/layout/Navbar";
import { Footer } from "../../components/landing/Footer";
import { BookOpen, HelpCircle, ShieldAlert, Smartphone } from "lucide-react";
import Link from "next/link";

export default function HelpCenter() {
    const categories = [
        {
            title: "Getting Started",
            description: "Learn the basics of setting up your daily reading goal and logging your first session.",
            icon: <BookOpen className="w-6 h-6" />
        },
        {
            title: "Managing Streaks",
            description: "Understand exactly how the streak counter calculates your consistency and handles missed days.",
            icon: <Smartphone className="w-6 h-6" />
        },
        {
            title: "Data & Privacy",
            description: "Information about local storage, exporting data, and our privacy commitments.",
            icon: <ShieldAlert className="w-6 h-6" />
        },
        {
            title: "Settings & Customization",
            description: "How to toggle dark mode, reset your progress, and change your daily minute goal.",
            icon: <HelpCircle className="w-6 h-6" />
        }
    ];

    return (
        <div className="min-h-screen bg-gray-50">
            <Navbar />
            <main className="pt-32 pb-24">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center mb-16">
                        <h1 className="text-4xl font-extrabold text-gray-900 mb-4">Help Center</h1>
                        <p className="text-xl text-gray-600">Find answers and learn how to get the most out of ReadTrack.</p>
                    </div>

                    <div className="grid md:grid-cols-2 gap-6 mb-16">
                        {categories.map((category, idx) => (
                            <div key={idx} className="bg-white p-8 rounded-3xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow cursor-pointer">
                                <div className="flex items-center gap-4 mb-4">
                                    <div className="w-12 h-12 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center">
                                        {category.icon}
                                    </div>
                                    <h3 className="text-xl font-bold text-gray-900">{category.title}</h3>
                                </div>
                                <p className="text-gray-600 leading-relaxed">{category.description}</p>
                            </div>
                        ))}
                    </div>

                    <div className="bg-white p-12 rounded-3xl shadow-sm border border-gray-100 text-center">
                        <h2 className="text-2xl font-bold text-gray-900 mb-4">Can't find what you're looking for?</h2>
                        <p className="text-gray-600 mb-8 max-w-xl mx-auto">
                            Our support team is always ready to help you resolve any issues or answer specific questions about ReadTrack.
                        </p>
                        <Link href="/contact" className="inline-flex items-center justify-center px-8 py-4 text-base font-semibold text-white bg-blue-600 rounded-full hover:bg-blue-700 transition-colors shadow-lg">
                            Contact Support
                        </Link>
                    </div>
                </div>
            </main>
            <Footer />
        </div>
    );
}
