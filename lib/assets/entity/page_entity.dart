import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageEntity with JsonConvert<PageEntity> {
	List<dynamic> content;
	PagePageable pageable;
	bool last;
	int totalPages;
	int totalElements;
	bool first;
	PageSort sort;
	int number;
	int numberOfElements;
	int size;
	bool empty;
}

class PagePageable with JsonConvert<PagePageable> {
	PagePageableSort sort;
	int pageSize;
	int pageNumber;
	int offset;
	bool paged;
	bool unpaged;
}

class PagePageableSort with JsonConvert<PagePageableSort> {
	bool sorted;
	bool unsorted;
	bool empty;
}

class PageSort with JsonConvert<PageSort> {
	bool sorted;
	bool unsorted;
	bool empty;
}
