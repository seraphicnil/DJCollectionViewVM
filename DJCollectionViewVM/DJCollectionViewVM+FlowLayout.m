//
//  DJCollectionViewVM+UICollectionViewDelegateFlowLayout.m
//  DJCollectionViewVM
//
//  Created by Dokay on 16/2/1.
//  Copyright © 2016年 dj226. All rights reserved.
//

#import "DJCollectionViewVM+FlowLayout.h"
#import "DJCollectionViewVMCell.h"
#import "DJCollectionViewVMReusableView.h"

@implementation DJCollectionViewVM (FlowLayout)

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: sizeForItemAtIndexPath:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }else{
        DJCollectionViewVMSection *section = [self.sections objectAtIndex:indexPath.section];
        DJCollectionViewVMRow *row = [section.rows objectAtIndex:indexPath.row];
        if (row.rowSize.height > 0) {
            return row.rowSize;
        }
        
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            if (row.rowSize.height == 0 || row.dj_caculateSizeForceRefresh) {
                if (row.sizeCaculateType == DJCellSizeCaculateDefault) {
                    Class cellClass = [self.registeredClasses objectForKey:row.class];
                    row.rowSize = [cellClass sizeWithRow:row collectionViewVM:self];
                }else{
                    //auto size
                    row.rowSize = [self sizeWithAutoLayoutCellWithIndexPath:indexPath];
                }
            }
            return row.rowSize;
            
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.itemSize.width != 0 && flowFayout.itemSize.height != 0) {
//                return flowFayout.itemSize;
//            }
        }
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: insetForSectionAtIndex:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }else{
//        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.sectionInset.top != 0  || flowFayout.sectionInset.bottom != 0) {
//                return flowFayout.sectionInset;
//            }
//        }
        DJCollectionViewVMSection *sectionVM = [self.sections objectAtIndex:section];
        return sectionVM.sectionInset;
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: minimumLineSpacingForSectionAtIndex:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }else{
        DJCollectionViewVMSection *sectionVM = [self.sections objectAtIndex:section];
        return sectionVM.minimumLineSpacing;
//        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.minimumLineSpacing != 0) {
//                return flowFayout.minimumLineSpacing;
//            }
//        }
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: minimumInteritemSpacingForSectionAtIndex:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }else{
        DJCollectionViewVMSection *sectionVM = [self.sections objectAtIndex:section];
        return sectionVM.minimumInteritemSpacing;
//        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.minimumInteritemSpacing != 0) {
//                return flowFayout.minimumInteritemSpacing;
//            }
//        }
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: referenceSizeForHeaderInSection:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }else{
        DJCollectionViewVMSection *sectionVM = [self.sections objectAtIndex:section];
        DJCollectionViewVMReusable *reusableVM = sectionVM.headerReusabelVM;
        if (reusableVM) {
            if (reusableVM.resuableSize.height > 0) {
                return reusableVM.resuableSize;
            }
            
            NSString *reusableViewClass = self.registeredReusableClasses[NSStringFromClass(sectionVM.headerReusabelVM.class)];
            if (reusableVM.sizeCaculateType == DJReusableSizeCaculateTypeDefault) {
                reusableVM.resuableSize = [NSClassFromString(reusableViewClass) sizeWithResuableVM:sectionVM.headerReusabelVM collectionViewVM:sectionVM.collectionViewVM];
            }else{
                //auto size
                reusableVM.resuableSize = [self sizeWithAutoLayoutReusableViewWithSection:section isHead:YES];
            }
            return sectionVM.headerReusabelVM.resuableSize;
        }
        return sectionVM.headerReferenceSize;
        
//        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.headerReferenceSize.height != 0) {
//                return flowFayout.headerReferenceSize;
//            }
//        }
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if ([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.delegate respondsToSelector:@selector(collectionView: layout: referenceSizeForFooterInSection:)]){
        return [self.delegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }else{
        DJCollectionViewVMSection *sectionVM = [self.sections objectAtIndex:section];
        DJCollectionViewVMReusable *reusableVM = sectionVM.footerReusableVM;
        if (reusableVM) {
            if (reusableVM.resuableSize.height > 0) {
                return reusableVM.resuableSize;
            }
            
            NSString *reusableViewClass = self.registeredReusableClasses[NSStringFromClass(sectionVM.footerReusableVM.class)];
            if (reusableVM.sizeCaculateType == DJReusableSizeCaculateTypeDefault) {
                reusableVM.resuableSize = [NSClassFromString(reusableViewClass) sizeWithResuableVM:sectionVM.footerReusableVM collectionViewVM:sectionVM.collectionViewVM];
            }else{
                //auto size
                reusableVM.resuableSize = [self sizeWithAutoLayoutReusableViewWithSection:section isHead:NO];
            }
            return sectionVM.footerReusableVM.resuableSize;
        }
        return sectionVM.footerReferenceSize;
//        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//            UICollectionViewFlowLayout *flowFayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//            if (flowFayout.footerReferenceSize.height >= 0) {
//                return flowFayout.footerReferenceSize;
//            }
//        }
    }
    return CGSizeZero;
}

@end
