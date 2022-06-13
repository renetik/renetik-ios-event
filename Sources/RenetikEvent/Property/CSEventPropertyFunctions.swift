public func property<T>(_ value: T, _ onApply: ((T) -> ())? = nil) -> CSEventPropertyImpl<T> {
    CSEventPropertyImpl(value: value, onApply: onApply)
}

//func property<T>(_ key: T, _  default: String, _ onApply: ((T) -> Unit)? = nil) -> CSProperty<T> {
//    application.store.property(key, default, onApply)
//}

//fun property(key: String, default: String, onApply: ((value: String) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(key: String, default: Float, onApply: ((value: Float) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(key: String, default: Int, onApply: ((value: Int) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(
//        key: String, default: Boolean,
//        onApply: ((value: Boolean) -> Unit)? = null
//) = application.store.property(key, default, onApply)
//
//fun <T> property(
//        key: String, values: List<T>, default: T,
//        onApply: ((value: T) -> Unit)? = null
//) = application.store.property(key, values, default, onApply)
//
//fun <T> property(
//        key: String, values: List<T>, defaultIndex: Int = 0,
//        onApply: ((value: T) -> Unit)? = null
//) = application.store.property(key, values, values[defaultIndex], onApply)
