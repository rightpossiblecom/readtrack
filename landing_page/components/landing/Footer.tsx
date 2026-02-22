import Link from "next/link";
import Image from "next/image";

export function Footer() {
    return (
        <footer className="bg-white border-t border-gray-100 pt-16 pb-8">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
                    <div className="col-span-1 md:col-span-2">
                        <Link href="/" className="flex items-center gap-2 mb-4">
                            <Image src="/logo.png" alt="ReadTrack Logo" width={32} height={32} className="rounded-md" />
                            <span className="font-bold text-xl text-gray-900">ReadTrack</span>
                        </Link>
                        <p className="text-gray-500 max-w-sm mt-4">
                            A simple reading time tracker focusing on daily minutes and consistency. Build a lasting reading habit without distractions.
                        </p>
                    </div>
                    <div>
                        <h4 className="font-semibold text-gray-900 mb-6 tracking-wide">Legal</h4>
                        <ul className="space-y-4">
                            <li><Link href="/privacy-policy" className="text-gray-500 hover:text-blue-600 transition-colors">Privacy Policy</Link></li>
                            <li><Link href="/terms" className="text-gray-500 hover:text-blue-600 transition-colors">Terms of Service</Link></li>
                        </ul>
                    </div>
                    <div>
                        <h4 className="font-semibold text-gray-900 mb-6 tracking-wide">Support</h4>
                        <ul className="space-y-4">
                            <li><Link href="/help" className="text-gray-500 hover:text-blue-600 transition-colors">Help Center</Link></li>
                            <li><Link href="/contact" className="text-gray-500 hover:text-blue-600 transition-colors">Contact Us</Link></li>
                        </ul>
                    </div>
                </div>
                <div className="pt-8 border-t border-gray-100 flex flex-col md:flex-row justify-between items-center gap-4">
                    <p className="text-gray-400 text-sm">© {new Date().getFullYear()} ReadTrack. All rights reserved.</p>
                </div>
            </div>
        </footer>
    );
}
