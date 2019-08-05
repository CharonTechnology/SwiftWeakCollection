// SwiftWeakCollection - Collections to keep weak or unowned reference
// Written in 2019 by Natsuki Kawai <kawai@charon.tech>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
// You should have received a copy of the CC0 Public Domain Dedication
// along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

struct WeakReference<T: AnyObject> {
	weak var value: T?
	init(_ value: T?) {
		self.value = value
	}
}
