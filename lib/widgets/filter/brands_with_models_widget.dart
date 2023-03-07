import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/providers/search_by_filter_provider.dart';
import 'package:dream_access/widgets/filter/choice_widget.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';

class BrandsWithModelsWidget extends StatefulWidget {
  const BrandsWithModelsWidget({super.key});

  @override
  State<BrandsWithModelsWidget> createState() => _BrandsWithModelsWidgetState();
}

class _BrandsWithModelsWidgetState extends State<BrandsWithModelsWidget> {
  var _isBrandPressed = false;
  var _brandIndex = 0;
  void _clickBrandFct(int brandId) {
    context.read<FilterProvider>().modelsByIdFct(brandId);
    context.read<FilterProvider>().filterPressedFct(true);
    // context.read<SearchByFilterProvider>().selectBrandFct();
    context.read<SearchByFilterProvider>().mapFct("carmake", brandId);

    setState(() {
      _brandIndex = brandId;
      _isBrandPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<FilterProvider>();

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listenData.brands.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                _clickBrandFct(listenData.brands[index].id);
                // print(listenData.b)
              },
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 64.h,
                    width: 64.w,
                    margin: EdgeInsets.only(right: 17.w),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isBrandPressed &&
                                _brandIndex == listenData.brands[index].id
                            // &&
                            // context
                            //     .watch<SearchByFilterProvider>()
                            // .selectBrand
                            ? Theme.of(context).primaryColor
                            : GeneralData.borderColor,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: listenData.brands[index].logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(height: 10),
                  SizedBox(
                    width: 64.w,
                    child: Text(
                      listenData.brands[index].name,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Gap(height: 15),
        _isBrandPressed
            //  && context.watch<SearchByFilterProvider>().selectBrand
            ? ModelsWidget(
                list: listenData.modelsById,
              )
            : const SizedBox(),
      ],
    );
  }
}
