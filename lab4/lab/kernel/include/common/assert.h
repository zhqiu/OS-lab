#ifndef __ASSERT_H__
#define __ASSERT_H__

int abort(const char *, int, int);
void put(char);

/* assert: 断言条件为真，若为假则蓝屏退出 */
#define assert(cond, error) \
	((cond) ? (0) : (abort(__FILE__, __LINE__, error)))

// my putChar
#define myput(ch) (put(ch))

#endif
