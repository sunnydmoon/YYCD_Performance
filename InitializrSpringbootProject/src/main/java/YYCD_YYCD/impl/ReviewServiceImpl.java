package YYCD_YYCD.Impl;

import YYCD_YYCD.domain.Review;
import YYCD_YYCD.dao.ReviewDao;
import YYCD_YYCD.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewDao reviewDao;

    @Autowired
    public ReviewServiceImpl(ReviewDao reviewDao) {
        this.reviewDao = reviewDao;
    }

    @Override
    public Review saveReview(Review review) {
        return reviewDao.save(review);
    }

    @Override
    public List<Review> getAllReviews() {
        return reviewDao.findAll();
    }

    @Override
    public Review getReviewById(Long id) {
        Optional<Review> reviewOptional = reviewDao.findById(id);
        return reviewOptional.orElse(null);
    }

    @Override
    public Review updateReview(Review review) {
        if (review.getId() != null && reviewDao.existsById(review.getId())) {
            return reviewDao.save(review);
        }
        return null;
    }

    @Override
    public void deleteReview(Long id) {
        reviewDao.deleteById(id);
    }
}