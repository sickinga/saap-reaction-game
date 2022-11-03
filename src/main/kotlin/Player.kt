import java.sql.Time

class Player(id:String) {
    var time: Time? = null
        get() = field
        set(value) {
            field = value
        }
}