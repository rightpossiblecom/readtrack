"use client";
import { useState } from "react";
import { ChevronDown, ChevronUp } from "lucide-react";

export function FAQ() {
    const [openIdx, setOpenIdx] = useState<number | null>(0);

    const faqs = [
        {
            question: "Do I need to create an account?",
            answer: "No, ReadTrack stores all your data locally on your device. There's no login required and no cloud syncing, ensuring your data remains completely private."
        },
        {
            question: "Can I track specific books?",
            answer: "ReadTrack is designed strictly as a time and consistency tracker. We intentionally omitted complex database features like book tracking to keep the experience as simple and distraction-free as possible."
        },
        {
            question: "What happens if I forget to log my reading?",
            answer: "If you miss a day, your streak will reset to zero. This is a core part of the habit-building process to encourage daily consistency."
        },
        {
            question: "Can I change my daily minute goal?",
            answer: "Yes, you can easily adjust your daily reading goal in the simple settings menu. Whether it's 5 minutes or an hour, the app adapts to your chosen target."
        },
        {
            question: "Is there a dark mode?",
            answer: "Yes, ReadTrack includes a system-matching dark mode to ensure tracking your reading before bed is easy on the eyes."
        }
    ];

    return (
        <section id="faq" className="py-24 bg-gray-50">
            <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center mb-16">
                    <h2 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Frequently Asked Questions</h2>
                </div>
                <div className="space-y-4">
                    {faqs.map((faq, idx) => (
                        <div key={idx} className="bg-white rounded-2xl shadow-sm overflow-hidden border border-gray-100">
                            <button
                                className="w-full px-8 py-6 text-left flex justify-between items-center focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-inset"
                                onClick={() => setOpenIdx(openIdx === idx ? null : idx)}
                            >
                                <span className="text-lg font-semibold text-gray-900">{faq.question}</span>
                                {openIdx === idx ? <ChevronUp className="w-5 h-5 text-gray-500" /> : <ChevronDown className="w-5 h-5 text-gray-500" />}
                            </button>
                            {openIdx === idx && (
                                <div className="px-8 pb-6 text-gray-600 leading-relaxed border-t border-gray-50 pt-4">
                                    {faq.answer}
                                </div>
                            )}
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}
