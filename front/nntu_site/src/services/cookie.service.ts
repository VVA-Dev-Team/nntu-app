export default class CookieService {
    static getCookie(name: string) {
        var results = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
        if (results)
            return (unescape(results[2]));
        else
            return null;
    }
    static deleteCookie(name: string) {
        if (this.getCookie(name)) {
            document.cookie = name + "=" + ";expires=Thu, 01 Jan 1970 00:00:01 GMT";
        }
    }
}